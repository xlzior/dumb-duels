//
//  LandEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import DuelKit

struct LandEvent: Event {
    var priority = 2

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let playerSystem = systems.get(ofType: PlayerSystem.self) else {
            return
        }
        playerSystem.possibleLand(playerId: entityId)
    }
}
