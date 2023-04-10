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
    private let cannonballs: Assemblage3<CannonballComponent, PhysicsComponent, SoundComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannonballs = entityManager.assemblage(
            requiredComponents: CannonballComponent.self, PhysicsComponent.self, SoundComponent.self)
    }

    func update() {
        for (cannonball, physics, sound) in cannonballs
        where Date() > cannonball.expiryDate {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true

            sound.sounds[TASoundTypes.cannonballExtinguish]?.play()
        }
    }

    func removeAllCannonballs() {
        for (_, physics, _) in cannonballs {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }
}
