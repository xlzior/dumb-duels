//
//  SpaceshipDestroyedEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit

struct SpaceshipDestroyedEvent: Event {
    var priority = 3

    let spaceshipId: EntityID

    func execute(with systems: SystemManager) {
        guard let particleSystem = systems.get(ofType: ParticleSystem.self),
              let animationCreatorSystem = systems.get(ofType: SPAnimationCreatorSystem.self),
              let soundSystem = systems.get(ofType: SoundSystem.self),
              let roundSystem = systems.get(ofType: SPRoundSystem.self),
              let bulletSystem = systems.get(ofType: BulletSystem.self),
              let powerupSystem = systems.get(ofType: PowerupSystem.self) else {
            return
        }

        particleSystem.createExplodingParticles(for: spaceshipId)

        animationCreatorSystem.resetMapping()
        soundSystem.play(sound: ExplodeSound())
        bulletSystem.destroyAllBullets()
        powerupSystem.destroyAllPowerups()
        powerupSystem.destroyAllRocks()
        roundSystem.reset()
    }
}
