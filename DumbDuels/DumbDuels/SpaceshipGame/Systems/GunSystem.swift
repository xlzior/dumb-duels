//
//  GunSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class GunSystem: System {
    unowned var entityManager: EntityManager
    private var entityCreator: SpaceshipEntityCreator
    private var lastFired = [EntityID: Date]()
    private var spaceshipsWithGun: Assemblage4<SpaceshipComponent, GunComponent, PositionComponent, RotationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.entityCreator = SpaceshipEntityCreator(entityManager: entityManager)
        self.spaceshipsWithGun = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, GunComponent.self,
            PositionComponent.self, RotationComponent.self)
    }

    func update() {
        for (entity, spaceship, gun, position, rotation) in spaceshipsWithGun.entityAndComponents {
            if gun.numBulletsLeft == 0 {
                entity.remove(componentType: GunComponent.typeId)
                return
            }

            if let lastFired = gun.lastFired,
               Date() - lastFired < SpaceshipConstants.gunInterval {
                return
            }

            let bulletPosition = position.position + CGVector(angle: rotation.angleInRadians)
            entityCreator.createBullet(index: spaceship.index, from: entity.id,
                                       angle: rotation.angleInRadians, position: bulletPosition)
            gun.numBulletsLeft -= 1
            gun.lastFired = Date()
        }
    }
}
