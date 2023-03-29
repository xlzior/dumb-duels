//
//  BombPowerup.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit
import CoreGraphics

struct BombPowerup: Powerup {
    func apply(to playerId: EntityID, in entityManager: EntityManager) {
        guard let spaceship: SpaceshipComponent = entityManager.getComponent(for: playerId),
              let playerPosition: PositionComponent = entityManager.getComponent(for: playerId) else {
            return
        }
        let entityCreator = SPEntityCreator(entityManager: entityManager)
        // Bing Sen TODO: what if I want to have different radius and number of bullets for each bomb
        for i in 0..<SPConstants.bombNumBullets {
            let angle = i * 2 * Double.pi / Double(SPConstants.bombNumBullets)
            // TODO: User player position for now, but by right should use the BombComponent entity's position
            let displacementFromPlayer = CGVector(angle: angle) * (SPConstants.bombRadius + SPSizes.bullet.height / 2)
            let bulletPosition = playerPosition.position + displacementFromPlayer

            entityCreator.createBullet(index: spaceship.index, from: playerId,
                                       angle: angle, position: bulletPosition,
                                       lifespan: SPConstants.bombBulletLifespan)
        }
    }
}
