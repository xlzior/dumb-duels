//
//  SoundComponent.swift
//
//
//  Created by Esmanda Wong on 7/4/23.
//

import Foundation

public typealias SoundType = String

public class SoundComponent: Component {
    public var id: ComponentID
    public var sounds: [SoundType: Sound]
    public var shouldDestroyEntityOnEnd: Bool

    public init(sounds: [SoundType: Sound], shouldDestroyEntityOnEnd: Bool = false) {
        self.id = ComponentID()
        self.sounds = sounds
        self.shouldDestroyEntityOnEnd = shouldDestroyEntityOnEnd
    }
}
