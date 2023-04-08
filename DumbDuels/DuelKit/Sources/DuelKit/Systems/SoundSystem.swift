//
//  SoundSystem.swift
//
//
//  Created by Esmanda Wong on 7/4/23.
//

import AVFoundation

public class SoundSystem: System {
    unowned var entityManager: EntityManager

    var player: AVAudioPlayer?
    var sounds: Assemblage1<SoundComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.sounds = entityManager.assemblage(requiredComponents: SoundComponent.self)
    }

    public func update() {
        for (soundComponent) in sounds {
            for sound in soundComponent.sounds.values {
                guard sound.isPlaying else {
                    continue
                }
                do {
    //                player?.insert(AVPlayerItem(url: sound.url), after: nil)
                    player = try AVAudioPlayer(contentsOf: sound.url)
                    player?.play()
                    sound.isPlaying = false
                } catch {
                    print("AVPLAYER", error.localizedDescription)
                }
            }
        }
    }
}
