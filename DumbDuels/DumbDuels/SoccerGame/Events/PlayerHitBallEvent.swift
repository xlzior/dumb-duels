//
//  PlayerHitBallEvent.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 12/4/23.
//

import DuelKit

struct PlayerHitBallEvent: Event {
    var priority: Int = 2

    func execute(with systems: DuelKit.SystemManager) {
        guard let soundControllerSystem = systems.get(ofType: SOSoundControllerSystem.self) else {
            return
        }

        soundControllerSystem.playCollideSound()
    }
}
