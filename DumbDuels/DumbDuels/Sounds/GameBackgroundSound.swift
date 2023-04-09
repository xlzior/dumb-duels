//
//  GameBackgroundSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class GameBackgroundSound: Sound {
    var isPlaying = true
    var url: URL = Bundle.main.url(forResource: "game-bg", withExtension: "mp3")!
    var volume: Float = 0.25
    var numLoop: Int = -1
}
