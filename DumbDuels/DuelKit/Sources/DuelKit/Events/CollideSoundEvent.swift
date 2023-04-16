//
//  CollideSoundEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 10/4/23.
//

public struct CollideSoundEvent: Event {
    public var priority = 2

    public var sound: Sound

    public init(sound: Sound, priority: Int = 2) {
        self.priority = priority
        self.sound = sound
    }

    public func execute(with systems: SystemManager) {
        guard let soundSystem = systems.get(ofType: SoundSystem.self) else {
            return
        }

        soundSystem.play(sound: sound)
    }
}
