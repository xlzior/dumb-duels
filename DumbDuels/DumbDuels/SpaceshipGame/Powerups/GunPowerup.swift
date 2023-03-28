//
//  GunPowerup.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

struct GunPowerup: Powerup {
    func apply(to playerId: EntityID, in entityManager: EntityManager) {
        entityManager.assign(component: GunComponent(), to: playerId)
    }
}
