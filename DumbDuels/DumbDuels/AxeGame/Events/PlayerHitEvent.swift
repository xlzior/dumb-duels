//
//  PlayerHitEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import DuelKit

struct PlayerHitEvent: Event {
    var priority = 2

    var entityId: EntityID
    var hitBy: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: AXScoreSystem.self),
              let axeParticleSystem = systems.get(ofType: AxeParticleSystem.self),
              let playerSystem = systems.get(ofType: PlayerSystem.self) else {
            return
        }

        scoreSystem.handleAxeHitPlayer(withEntityId: entityId)
        axeParticleSystem.createParticlesFrom(axeEntityId: hitBy)
        playerSystem.handleAxeHitPlayer(withEntityId: entityId)
    }
}
