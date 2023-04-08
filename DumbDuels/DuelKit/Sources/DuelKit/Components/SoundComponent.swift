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

    public init(sounds: [SoundType: Sound]) {
        self.id = ComponentID()
        self.sounds = sounds
    }
}
