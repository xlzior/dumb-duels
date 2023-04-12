//
//  PlayerHitWallEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 12/4/23.
//

import DuelKit

struct PlayerHitWallEvent: Event {
    var priority: Int = 4

    var playerId: EntityID

    func execute(with systems: SystemManager) {
        guard let particleSystem = systems.get(ofType: ParticleSystem.self),
              let soundSystem = systems.get(ofType: SoundSystem.self) else {
            return
        }

        particleSystem.createExplodingParticles(for: playerId)
        soundSystem.play(sound: CollideSound())
    }
}
