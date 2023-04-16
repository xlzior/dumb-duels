//
//  SpaceshipRecreatedEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit

struct SpaceshipRecreatedEvent: Event {
    var priority = 1

    let firstSpaceshipId: EntityID
    let secondSpaceshipId: EntityID

    // TODO: Remove or reimplement this without updateIndexToIdMapping
    func execute(with systems: SystemManager) {
        systems.setupInputSystemMapping(firstPlayedId: firstSpaceshipId, secondPlayerId: secondSpaceshipId)
    }
}
