//
//  SpaceshipCollideEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit

struct SpaceshipCollideEvent: Event {
    var priority = 2

    func execute(with systems: SystemManager) {
        guard let soundSystem = systems.get(ofType: SoundSystem.self) else {
            return
        }

        soundSystem.play(sound: CollideSound())
    }

}
