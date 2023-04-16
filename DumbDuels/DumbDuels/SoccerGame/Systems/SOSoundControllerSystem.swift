//
//  SOSoundControllerSystem.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 12/4/23.
//

import DuelKit
import Foundation

class SOSoundControllerSystem: System {

    private let entityManager: EntityManager
    private let collideSoundType: String = "collide"
    private var lastCollideSoundPlayedTime: Date?
    private let minPlayInterval = 0.2

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.lastCollideSoundPlayedTime = nil
    }

    func update() {

    }

    func playCollideSound() {
        guard let lastCollideSoundPlayedTime else {
            createSoundAndPlay()
            return
        }

        let timeElapsedSinceLastPlay = Date() - lastCollideSoundPlayedTime
        if timeElapsedSinceLastPlay >= minPlayInterval {
            createSoundAndPlay()
        }
    }

    private func createSoundAndPlay() {
        entityManager.createEntity {
            SoundComponent(sounds: [collideSoundType: CollideSound(isPlaying: true)], shouldDestroyEntityOnEnd: true)
        }
        lastCollideSoundPlayedTime = Date()
    }
}
