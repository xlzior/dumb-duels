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

    private var thrownAxe: Assemblage4<AxeComponent, PositionComponent, RotationComponent, PhysicsComponent>
    private var unthrownAxe: Assemblage1<AxeComponent>
    private var players: Assemblage4<PlayerComponent, ScoreComponent, PositionComponent, PhysicsComponent>
    private var throwStrength: Assemblage2<ThrowStrengthComponent, SizeComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.thrownAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self)
        self.unthrownAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self,
            excludedComponents: PhysicsComponent.self)
        self.players = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, ScoreComponent.self,
            PositionComponent.self, PhysicsComponent.self)
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
        for (entity, _, score, _, _) in players.entityAndComponents where score.score >= 5 {
            eventFirer.fire(GameWonEvent(entityId: entity.id))
        }
    }

    func reset() {
        for (entity, player, _, playerPosition, playerPhysics) in players.entityAndComponents {
            // reset player
            player.fsm.changeState(name: .holdingAxe)
            playerPosition.position = Positions.players[player.idx]
            playerPhysics.velocity = CGVector.zero

            // reset axe
            guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(for: entity.id),
                  let (_, axePosition, axeRotation, physics) =
                    thrownAxe.getComponents(for: holdingAxe.axeEntityID) else {
                return
            }
            let horizontalOffset = Sizes.axeOffsetFromPlayer(facing: playerPosition.faceDirection)
            axePosition.position = playerPosition.position + CGPoint(x: horizontalOffset, y: 0)
            axeRotation.angleInRadians = 0
            physics.toBeRemoved = true
        }

        for (throwStrengthComponent, sizeComponent) in throwStrength {
            throwStrengthComponent.throwStrength = Constants.defaultThrowStrength
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
