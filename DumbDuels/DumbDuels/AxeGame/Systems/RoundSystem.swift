//
//  RoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class RoundSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    private var thrownAxe: Assemblage3<AxeComponent, PositionComponent, PhysicsComponent>
    private var unthrownAxe: Assemblage1<AxeComponent>
    private var players: Assemblage3<PlayerComponent, ScoreComponent, PositionComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.thrownAxe = entityManager.assemblage(requiredComponents: AxeComponent.self, PositionComponent.self, PhysicsComponent.self)
        self.unthrownAxe = entityManager.assemblage(requiredComponents: AxeComponent.self, excludedComponents: PhysicsComponent.self)
        self.players = entityManager.assemblage(requiredComponents: PlayerComponent.self, ScoreComponent.self,
                                                PositionComponent.self)
    }

    func update() {
        if isAllAxeThrown() && isAllThrownAxeOutOfBounds() {
            checkWin()
            reset()
        }
    }

    func checkWin() {
        for (entity, _, score, _) in players.entityAndComponents where score.score >= 5 {
            eventFirer.fire(GameWonEvent(entityId: entity.id))
        }
    }

    func reset() {
        print("trying to reset")
        for (entity, player, _, playerPosition) in players.entityAndComponents {
            // reset player
            player.fsm.changeState(name: .holdingAxe)
            playerPosition.position = Positions.players[player.idx]
            // TODO: reset velocity?

            // TODO: can combine 2 guards
            guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(for: entity.id) else {
                print("dont have holding axe component")
                return
            }
            print("holdingAxe id: \(holdingAxe.axeEntityID)")
            guard let (entity, axe, axePosition, physics) =
                    thrownAxe.getEntityAndComponents(for: holdingAxe.axeEntityID) else {
                print("inside here")
                return
            }
            let horizontalOffset = (Sizes.player.width / 2 + Sizes.axe.height / 2 + 1) *
                                   playerPosition.faceDirection.rawValue
            axePosition.position = playerPosition.position + CGPoint(x: horizontalOffset, y: 0)
            print("axeId: \(entity.id), position: \(axePosition.position)")
            physics.toBeRemoved = true
        }
    }

    private func isAllAxeThrown() -> Bool {
        for _ in unthrownAxe.entities {
            print("not all axe thrown")
            return false
        }
        print("all axes thrown")
        return true
    }

    private func isAllThrownAxeOutOfBounds() -> Bool {
        let frame = CGRect(origin: CGPoint.zero, size: Sizes.game)
        for (entity, _, position, _) in thrownAxe.entityAndComponents where frame.contains(position.position) {
            print("axe \(entity.id) is still in bounds")
            return false
        }
        print("all axes thrown are out of bounds")
        return true
    }
}
