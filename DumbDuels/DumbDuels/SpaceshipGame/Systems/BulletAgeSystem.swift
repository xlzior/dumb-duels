//
//  BulletAgeSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class BulletAgeSystem: System {
    unowned var entityManager: EntityManager
    private var bullets: Assemblage2<BulletComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.bullets = entityManager.assemblage(
            requiredComponents: BulletComponent.self, PhysicsComponent.self)
    }

    func update() {
        for (bullet, physics) in bullets
        where Date() - bullet.createdAt > SPConstants.bulletLifespan {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }
}
