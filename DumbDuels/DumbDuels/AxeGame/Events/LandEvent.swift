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
        guard let playerAxeSystem = systems.get(ofType: PlayerAxeSystem.self) else {
            return
        }
        print("Possible landing of player \(entityId)")
        playerAxeSystem.possibleLand(playerId: entityId)
    }

}
