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
        guard let animationCreatorSystem = systems.get(ofType: SPAnimationCreatorSystem.self),
              let roundSystem = systems.get(ofType: SPRoundSystem.self),
              let bulletSystem = systems.get(ofType: BulletSystem.self),
              let powerupSystem = systems.get(ofType: PowerupSystem.self) else {
            return
        }

        // If restart round destroys all spaceships before creating new ones, then might as well ask
        // animationCreatorSystem to clear its hashmap
        animationCreatorSystem.createSpaceshipParticles(spaceshipId: spaceshipId)

        // TODO: delay all these reset until the destroy animation ends
        animationCreatorSystem.resetMapping()
        bulletSystem.destroyAllBullets()
        powerupSystem.destroyAllPowerups()
        powerupSystem.destroyAllRocks()
        roundSystem.reset()
    }
}
