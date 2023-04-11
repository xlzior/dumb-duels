//
//  PlayerJumpSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class PlayerJumpSound: Sound {
    var isPlaying = false
    var url: URL = Bundle.main.url(forResource: "jump", withExtension: "mp3")!
    var volume: Float = 1
    var numLoop: Int = 0
}
