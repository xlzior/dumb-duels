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
        guard let (position, rotation, physics) = entityManager
            .assemblage(requiredComponents: PositionComponent.self,
                        RotationComponent.self, PhysicsComponent.self)
            .getComponents(for: playerId) else {
            return
        }
        let entityCreator = SpaceshipEntityCreator(entityManager: entityManager)
        let rockPosition = position.position + CGVector(angle: rotation.angleInRadians)
        entityCreator.createRock(at: rockPosition, angle: rotation.angleInRadians, justActivatedBy: playerId)
    }
}
