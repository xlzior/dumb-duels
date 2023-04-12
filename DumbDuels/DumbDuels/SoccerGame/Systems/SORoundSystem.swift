//
//  SORoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import DuelKit
import Foundation

class SORoundSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    private let players: Assemblage4<SoccerPlayerComponent, PositionComponent, RotationComponent, PhysicsComponent>
    private let ball: Assemblage4<BallComponent, PositionComponent, RotationComponent, PhysicsComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.players = entityManager.assemblage(
            requiredComponents: SoccerPlayerComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self)
        self.ball = entityManager.assemblage(
            requiredComponents: BallComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self)
    }

    func update() {

    }

    func reset() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            eventFirer.fire(GameStartEvent())

            for (player, position, rotation, physics) in players {
                player.isMoving = false
                position.position = SOPositions.players[player.index]
                rotation.angleInRadians = SOPositions.playerRotations[player.index]
                physics.velocity = .zero
            }

            for (_, position, rotation, physics) in ball {
                position.position = SOPositions.ball
                rotation.angleInRadians = 0
                physics.velocity = .zero
            }
//        }
    }
}
