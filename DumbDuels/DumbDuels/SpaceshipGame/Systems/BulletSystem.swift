//
//  BulletSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class BulletSystem: System {
    unowned var entityManager: EntityManager
    private var bullets: Assemblage3<BulletComponent, PositionComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.bullets = entityManager.assemblage(
            requiredComponents: BulletComponent.self, PositionComponent.self, PhysicsComponent.self)
    }

    func update() {
        for (_, position, physics) in bullets
        where !Sizes.gameRect.contains(position.position) {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }

    func destroyAllBullets() {
        for (_, _, physics) in bullets {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }
}
