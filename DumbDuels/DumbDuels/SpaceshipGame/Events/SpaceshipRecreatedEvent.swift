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

    func execute(with systems: SystemManager) {
        systems.updateIndexToIdMapping(firstId: firstSpaceshipId, secondId: secondSpaceshipId)
    }
}
