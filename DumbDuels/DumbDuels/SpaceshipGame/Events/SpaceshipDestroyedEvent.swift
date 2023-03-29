//
//  SpaceshipDestroyedEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit

struct SpaceshipDestroyedEvent: Event {
    var priority = 2

    let spaceshipId: EntityID

    func execute(with systems: SystemManager) {
        // Bing Sen TODO: notify RoundSystem also to restart round
        guard let animationCreatorSystem = systems.get(ofType: SPAnimationCreatorSystem.self) else {
            return
        }

        // Bing Sen TODO: Note that this is only sufficient if restarting round does not destroy the non-destroyed spaceship
        // If restart round destroys all spaceships before creating new ones, then might as well ask
        // animationCreatorSystem to clear its hashmap
        animationCreatorSystem.onDestroy(spaceshipId: spaceshipId)
        animationCreatorSystem.createSpaceshipParticles(spaceshipId: spaceshipId)
    }
}
