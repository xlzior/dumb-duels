//
//  BulletHitPlayerEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

struct BulletHitPlayerEvent: Event {
    var priority = 2

    let bulletId: EntityID
    let playerId: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: SPScoreSystem.self) else {
            return
        }

        scoreSystem.handleBulletHitPlayer(bulletId: bulletId, playerId: playerId)
    }
}
