//
//  RockHitPlayerEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

struct RockHitPlayerEvent: Event {
    var priority = 2

    let rockId: EntityID
    let playerId: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: SPScoreSystem.self) else {
            return
        }

        scoreSystem.handleRockHitPlayer(rockId: rockId, playerId: playerId)
    }
}
