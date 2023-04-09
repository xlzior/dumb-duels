//
//  SPSoundSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit

class SPSoundSystem: System {
    unowned var entityManager: EntityManager

    private var spaceships: Assemblage2<SpaceshipComponent, SoundComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.spaceships = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, SoundComponent.self)
    }

    func update() {}

    func playExplodeSound(spaceshipId: EntityID) {
        for (entity, _, sound) in spaceships.entityAndComponents {
            guard entity.id == spaceshipId else {
                continue
            }

            sound.sounds[SPSoundTypes.spaceshipExplode]?.play()
        }
    }

    func playCollideSound(spaceshipId: EntityID) {
        for (entity, _, sound) in spaceships.entityAndComponents {
            guard entity.id == spaceshipId else {
                continue
            }

            sound.sounds[SPSoundTypes.spaceshipCollide]?.play()
        }
    }
}
