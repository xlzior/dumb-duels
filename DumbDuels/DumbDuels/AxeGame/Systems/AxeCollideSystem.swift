//
//  AxeCollideSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 8/4/23.
//

import DuelKit

class AxeCollideSystem: System {
    unowned var entityManager: EntityManager

    private var collidedAxe: Assemblage2<AxeComponent, SoundComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.collidedAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, SoundComponent.self)
    }

    func update() {}

    func playCollideSound(axeEntityId: EntityID) {
        for (entity, _, sound) in collidedAxe.entityAndComponents {
            guard entity.id == axeEntityId else {
                continue
            }

            sound.sounds[AXSoundTypes.axeCollide]?.play()
        }
    }
}
