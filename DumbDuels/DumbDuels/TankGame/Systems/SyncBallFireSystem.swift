//
//  SyncBallFireSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 11/4/23.
//

import DuelKit

class SyncBallFireSystem: System {
    unowned let entityManager: EntityManager
    private let cannonballFire: Assemblage3<CannonballFireComponent, PositionComponent, RotationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannonballFire = entityManager.assemblage(
            requiredComponents: CannonballFireComponent.self, PositionComponent.self, RotationComponent.self)
    }

    func update() {
        for (fire, position, rotation) in cannonballFire {
            guard let ballPosition: PositionComponent = entityManager.getComponent(
                ofType: PositionComponent.typeId, for: fire.ballId),
                  let ballPhysics: PhysicsComponent = entityManager.getComponent(
                ofType: PhysicsComponent.typeId, for: fire.ballId) else {
                continue
            }

            let offsetFromBall = TASizes.cannonball.height / 2 + TASizes.cannonballFire.height / 2
            position.position = ballPosition.position + ballPhysics.velocity.normalize() * offsetFromBall
            rotation.angleInRadians = ballPhysics.velocity.angle
        }
    }

}
