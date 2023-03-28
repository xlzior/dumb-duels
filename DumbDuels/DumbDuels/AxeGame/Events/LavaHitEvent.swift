//
//  LavaHitEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 28/3/23.
//

import DuelKit

struct LavaHitEvent: Event {
    var priority = 2

    var axeEntityId: EntityID

    func execute(with systems: SystemManager) {
        guard let axeParticleSystem = systems.get(ofType: AxeParticleSystem.self) else {
            return
        }

        axeParticleSystem.createParticlesFrom(axeEntityId: axeEntityId)
    }
}
