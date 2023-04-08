//
//  AXSounds.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 8/4/23.
//

import Foundation

struct AXSounds {
    static let playerJump: String = "player-jump"
    static let playerHit: String = "player-hit"
    static let axeCollide: String = "axe-collide"
    static let axeExplode: String = "axe-explode"

    static let playerJumpSound: URL = Bundle.main.url(forResource: "jump", withExtension: "mp3")!
    static let playerHitSound: URL = Bundle.main.url(forResource: "hurt", withExtension: "mp3")!
    static let axeCollideSound: URL = Bundle.main.url(forResource: "collide", withExtension: "mp3")!
    static let axeExplodeSound: URL = Bundle.main.url(forResource: "explode", withExtension: "mp3")!
}
