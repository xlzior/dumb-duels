//
//  LandEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct LandEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let playerSystem = systems.get(ofType: PlayerSystem.self) else {
            return
        }
        print("Possible landing of player \(entityId)")
        playerSystem.possibleLand(playerId: entityId)
    }
}
