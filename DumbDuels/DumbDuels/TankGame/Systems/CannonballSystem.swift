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
    private let cannonballs: Assemblage2<CannonballComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannonballs = entityManager.assemblage(
            requiredComponents: CannonballComponent.self, PhysicsComponent.self)
    }

    func update() {
        for (cannonball, physics) in cannonballs
        where Date() > cannonball.expiryDate {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }

    func removeAllCannonballs() {
        for (_, physics) in cannonballs {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }
}
