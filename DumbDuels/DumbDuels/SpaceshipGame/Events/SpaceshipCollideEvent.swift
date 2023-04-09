//
//  SpaceshipCollideEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit

struct SpaceshipCollideEvent: Event {
    var priority = 3

    let spaceshipId: EntityID

    func execute(with systems: SystemManager) {
        guard let soundSystem = systems.get(ofType: SPSoundSystem.self) else {
            return
        }

        soundSystem.playCollideSound(spaceshipId: spaceshipId)
    }

}
