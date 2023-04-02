//
//  GunPowerup.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import CoreGraphics
import DuelKit

struct GunPowerup: Powerup {
    let numBullets: Int = SPConstants.numBullets
    let gunInterval: CGFloat = SPConstants.gunInterval

    func apply(powerupId: EntityID, to playerId: EntityID, in entityManager: EntityManager) {
        if entityManager.has(componentTypeId: GunComponent.typeId, entityId: playerId) {
            entityManager.remove(componentType: GunComponent.typeId, from: playerId)
        }

        entityManager.assign(
            component: GunComponent(numBulletsLeft: numBullets, gunInterval: gunInterval),
            to: playerId)
    }
}
