//
//  PowerupSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class PowerupSystem: System {
    unowned var entityManager: EntityManager
    private var entityCreator: SPEntityCreator
    private var lastSpawned: Date?

    private var powerups: Assemblage2<PowerupComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.entityCreator = SPEntityCreator(entityManager: entityManager)
        self.powerups = entityManager.assemblage(requiredComponents: PowerupComponent.self, PhysicsComponent.self)
    }

    func update() {
        guard canSpawnPowerUp() else {
            return
        }

        entityCreator.createPowerup()
        lastSpawned = Date()
    }

    func applyPowerup(powerupId: EntityID, to playerId: EntityID) {
        guard let (powerup, physics) = powerups.getComponents(for: powerupId) else {
            return
        }
        powerup.powerup.apply(to: playerId, in: entityManager)
        physics.toBeRemoved = true
        physics.shouldDestroyEntityWhenRemove = true
    }

    private func canSpawnPowerUp() -> Bool {
        var isTimeToSpawn = true
        if let lastSpawned,
           Date() - lastSpawned <= SPConstants.powerupSpawnInterval {
            isTimeToSpawn = false
        }
        let hasReachedMaxSpwans = powerups.count >= SPConstants.maxPowerUpsOnField
        return isTimeToSpawn && !hasReachedMaxSpwans
    }

    func destroyAllPowerups() {
        for (_, physics) in powerups {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }
}
