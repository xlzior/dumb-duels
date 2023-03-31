//
//  GunPowerup.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

struct GunPowerup: Powerup {
    // TODO: take in numbullets as a parameter
    // Bing Sen TODO: Refactor Powerup design to use generics and updatableData
    func apply(to playerId: EntityID, in entityManager: EntityManager) {
        if entityManager.has(componentTypeId: GunComponent.typeId, entityId: playerId) {
            entityManager.remove(componentType: GunComponent.typeId, from: playerId)
        }
        // Bing Sen TODO: what if I do not want the default GunComponent
        entityManager.assign(component: GunComponent(), to: playerId)
    }
}
