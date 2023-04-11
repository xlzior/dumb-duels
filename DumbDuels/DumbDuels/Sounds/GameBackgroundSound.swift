//
//  GameBackgroundSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class GameBackgroundSound: Sound {
    var url: URL = Bundle.main.url(forResource: "game-bg", withExtension: "mp3")!

    var isPlaying: Bool
    var volume: Float
    var numLoop: Int

    init(isPlaying: Bool = true, volume: Float = 0.25, numLoop: Int = -1) {
        self.isPlaying = isPlaying
        self.volume = volume
        self.numLoop = numLoop
    }
}
