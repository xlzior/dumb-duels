//
//  BombPowerup.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit
import CoreGraphics

struct BombPowerup: Powerup {
    let numBullets: Int = SPConstants.bombNumBullets
    let bulletSize: CGSize = SPSizes.bullet
    let radius: CGFloat = SPConstants.bombRadius

    func apply(powerupId: EntityID, to playerId: EntityID, in entityManager: EntityManager) {
        guard let spaceship: SpaceshipComponent = entityManager.getComponent(for: playerId),
              let powerupPosition: PositionComponent = entityManager.getComponent(for: powerupId) else {
            return
        }
        let entityCreator = SPEntityCreator(entityManager: entityManager)
        for i in 0..<numBullets {
            let angle = i * 2 * Double.pi / Double(numBullets)
            let displacement = CGVector(angle: angle) * (radius + bulletSize.height / 2)
            let bulletPosition = powerupPosition.position + displacement

            let bullet = entityCreator.createBullet(index: spaceship.index, from: playerId,
                                       size: bulletSize, angle: angle,
                                       position: bulletPosition)

            // Only play sound for 2 of the bullets, else will cause a lag
            if i > 1 {
                guard let sound: SoundComponent = entityManager.getComponent(
                    ofType: SoundComponent.typeId, for: bullet.id) else {
                    continue
                }

                sound.sounds[SPSoundTypes.bullet]?.stop()
            }
        }
    }
}
