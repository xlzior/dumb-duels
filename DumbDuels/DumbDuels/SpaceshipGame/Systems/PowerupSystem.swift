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
    unowned var entityCreator: SPEntityCreator
    private var lastSpawned: Date?

    private var powerups: Assemblage4<PowerupComponent, PhysicsComponent, SizeComponent, PositionComponent>
    private var rocks: Assemblage2<RockComponent, PhysicsComponent>
    private var spaceships: Assemblage3<SpaceshipComponent, SizeComponent, PositionComponent>

    init(for entityManager: EntityManager, entityCreator: SPEntityCreator) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.powerups = entityManager.assemblage(requiredComponents: PowerupComponent.self,
                                                 PhysicsComponent.self, SizeComponent.self, PositionComponent.self)
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self,
                                                   SizeComponent.self, PositionComponent.self)
        self.rocks = entityManager.assemblage(requiredComponents: RockComponent.self, PhysicsComponent.self)
    }

    func update() {
        guard canSpawnPowerUp() else {
            return
        }
        let powerupPosition = getPowerupPosition(of: SPSizes.powerup.width)
        entityCreator.createPowerup(at: powerupPosition, of: SPSizes.powerup)
        lastSpawned = Date()
    }

    func applyPowerup(powerupId: EntityID, to playerId: EntityID) {
        guard let (powerup, physics, _, _) = powerups.getComponents(for: powerupId),
              !powerup.isActivated else {
            return
        }
        powerup.isActivated = true
        powerup.powerup.apply(powerupId: powerupId, to: playerId, in: entityManager)
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
        for (_, physics, _, _) in powerups {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }

    func destroyAllRocks() {
        for (_, physics) in rocks {
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true
        }
    }

    private func getPowerupPosition(of maxDimension: CGFloat) -> CGPoint {
        let boundingBox = CGSize(width: Sizes.game.width - maxDimension,
                                 height: Sizes.game.height - maxDimension)
        var position = CGPoint.random(within: boundingBox)
        position += CGPoint(x: maxDimension / 2, y: maxDimension / 2)
        while !canAdd(at: position, dimension: maxDimension) {
            position = CGPoint.random(within: boundingBox)
            position += CGPoint(x: maxDimension / 2, y: maxDimension / 2)
        }
        return position
    }

    private func canAdd(at position: CGPoint, dimension: CGFloat) -> Bool {
        // Check collision with existing powerups
        for (_, _, sizeComponent, positionComponent) in powerups {
            let otherDimension = max(sizeComponent.actualSize.height, sizeComponent.actualSize.width)
            let minimumDistanceApart = (otherDimension + dimension) / 2
            if positionComponent.position.distanceTo(position) <= minimumDistanceApart {
                return false
            }
        }

        // Check collision with spaceships
        for (_, sizeComponent, positionComponent) in spaceships {
            let otherDimension = max(sizeComponent.actualSize.height, sizeComponent.actualSize.width)
            let minimumDistanceApart = (otherDimension + dimension) / 2
            if positionComponent.position.distanceTo(position) <= minimumDistanceApart {
                return false
            }
        }
        return true
    }
}
