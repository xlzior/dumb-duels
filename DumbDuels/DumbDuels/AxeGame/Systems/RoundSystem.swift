//
//  RoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics
import DuelKit

class RoundSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer
    unowned var entityCreator: AXEntityCreator

    private var thrownAxe: Assemblage4<AxeComponent, PositionComponent, RotationComponent, PhysicsComponent>
    private var unthrownAxe: Assemblage2<AxeComponent, SyncXPositionComponent>
    private var players: Assemblage5<PlayerComponent, ScoreComponent, PositionComponent,
                                     PhysicsComponent, SyncXPositionComponent>
    private var platforms: Assemblage2<PlatformComponent, PositionComponent>
    private var throwStrength: Assemblage2<ThrowStrengthComponent, SizeComponent>

    private var isGameOver = false

    init(for entityManager: EntityManager, eventFirer: EventFirer, entityCreator: AXEntityCreator) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.entityCreator = entityCreator
        self.thrownAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self,
            excludedComponents: SyncXPositionComponent.self)
        self.unthrownAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, SyncXPositionComponent.self,
            excludedComponents: PhysicsComponent.self)
        self.players = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, ScoreComponent.self,
            PositionComponent.self, PhysicsComponent.self, SyncXPositionComponent.self)
        self.platforms = entityManager.assemblage(
            requiredComponents: PlatformComponent.self, PositionComponent.self)
        self.throwStrength = entityManager.assemblage(
            requiredComponents: ThrowStrengthComponent.self, SizeComponent.self)
    }

    func update() {
        if isAllAxeThrown() && isAllThrownAxeOutOfBounds() {
            checkWin()
            reset()
        }
    }

    func checkWin() {
        var winningEntities = [EntityID]()
        for (entity, _, score, _, _, _) in players.entityAndComponents
        where score.score >= AXConstants.winningScore {
            winningEntities.append(entity.id)
        }

        guard !winningEntities.isEmpty else {
            return
        }

        if winningEntities.count > 1 {
            eventFirer.fire(GameTieEvent())
        } else {
            eventFirer.fire(GameWonEvent(entityId: winningEntities[0]))
        }
        isGameOver = true
    }

    func reset() {
        if !isGameOver {
            eventFirer.fire(GameStartEvent())
        }

        // Destroy all thrown axes since they are out of bounds
        for (_, _, _, physicsComponent) in thrownAxe {
            physicsComponent.toBeRemoved = true
            physicsComponent.shouldDestroyEntityWhenRemove = true
        }
        for (playerEntity, player, _, playerPosition, playerPhysics, playerSyncX) in players.entityAndComponents {
            // create new axe
            let axe = entityCreator.createAxe(
                withHorizontalOffset: AXSizes.axeOffsetFromPlayer(facing: playerPosition.faceDirection),
                from: AXPositions.players[player.idx],
                of: AXSizes.axe,
                facing: playerPosition.faceDirection, onPlatform: playerSyncX.syncFrom
            )

            // reset player
            playerEntity.assign(component: HoldingAxeComponent(axeEntityID: axe.id))
            playerPhysics.velocity = CGVector.zero
        }

        for (throwStrengthComponent, sizeComponent) in throwStrength {
            throwStrengthComponent.throwStrength = AXConstants.defaultThrowStrength
            sizeComponent.xScale = throwStrengthComponent.throwStrength
        }
    }

    private func isAllAxeThrown() -> Bool {
        for _ in unthrownAxe.entities {
            return false
        }
        return true
    }

    private func isAllThrownAxeOutOfBounds() -> Bool {
        let frame = CGRect(origin: CGPoint.zero, size: Sizes.game)
        for (_, position, _, _) in thrownAxe where frame.contains(position.position) {
            return false
        }
        return true
    }
}
