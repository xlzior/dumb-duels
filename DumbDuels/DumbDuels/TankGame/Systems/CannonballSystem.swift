//
//  CannonballSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import Foundation
import DuelKit

class CannonballSystem: System {
    private let entityManager: EntityManager
    private let cannonballs: Assemblage4<CannonballComponent, PhysicsComponent, PositionComponent, SoundComponent>
    private let cannonballFire: Assemblage3<CannonballFireComponent, PositionComponent, RotationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannonballs = entityManager.assemblage(requiredComponents: CannonballComponent.self,
                                                    PhysicsComponent.self, PositionComponent.self, SoundComponent.self)
        self.cannonballFire = entityManager.assemblage(
            requiredComponents: CannonballFireComponent.self, PositionComponent.self, RotationComponent.self)
    }

    func update() {
        syncFireToCannonball()
        for (ballEntity, cannonball, physics, _, sound) in cannonballs.entityAndComponents
        where Date() > cannonball.expiryDate {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true

            sound.sounds[TASoundTypes.cannonballExtinguish]?.play()

            for (fireEntity, fire, _, _) in cannonballFire.entityAndComponents where fire.ballId == ballEntity.id {
                entityManager.destroy(entity: fireEntity)
            }
        }
    }

    func removeAllCannonballs() {
        for (entity, _, _, _) in cannonballFire.entityAndComponents {
            entityManager.destroy(entity: entity)
        }

        for (_, physics, _, _) in cannonballs {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }

    private func syncFireToCannonball() {
        for (fire, position, rotation) in cannonballFire {
            guard let (_, ballPhysics, ballPosition, _) = cannonballs.getComponents(for: fire.ballId) else {
                continue
            }

            let offsetFromBall = TASizes.cannonball.height / 2 + TASizes.cannonballFire.height / 2
            position.position = ballPosition.position + ballPhysics.velocity.normalized() * -1 * offsetFromBall
            rotation.angleInRadians = ballPhysics.velocity.angle - CGFloat.pi / 2
        }
    }
}
