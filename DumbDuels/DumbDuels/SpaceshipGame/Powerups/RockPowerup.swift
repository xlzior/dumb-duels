//
//  RockPowerup.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit
import CoreGraphics

struct RockPowerup: Powerup {
    func apply(to playerId: EntityID, in entityManager: EntityManager) {
        guard let (position, _, physics) = entityManager
            .assemblage(requiredComponents: PositionComponent.self,
                        RotationComponent.self, PhysicsComponent.self)
            .getComponents(for: playerId) else {
            return
        }
        let entityCreator = SPEntityCreator(entityManager: entityManager)

        let spaceshipHypothenuse = sqrt(SPSizes.spaceship.width * SPSizes.spaceship.width + SPSizes.spaceship.height * SPSizes.spaceship.height)
        let rockOffsetFromSpaceship = physics.velocity.normalize() * spaceshipHypothenuse
        let rockPosition = position.position + rockOffsetFromSpaceship
        let rockVelocity = physics.velocity * 1.2
        entityCreator.createRock(at: rockPosition, velocity: rockVelocity, justActivatedBy: playerId)
    }
}
