//
//  PlayerHitPowerupEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

struct PlayerHitPowerupEvent: Event {
    var priority = 2

    let powerupId: EntityID
    let playerId: EntityID

    func execute(with systems: SystemManager) {
        guard let powerupSystem = systems.get(ofType: PowerupSystem.self) else {
            return
        }

        powerupSystem.applyPowerup(powerupId: powerupId, to: playerId)
    }
}
