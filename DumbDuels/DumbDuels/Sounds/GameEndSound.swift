//
//  GameEndSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class GameEndSound: Sound {
    var url: URL = Bundle.main.url(forResource: "game-end", withExtension: "mp3")!

    var isPlaying: Bool
    var volume: Float
    var numLoop: Int

    init(isPlaying: Bool = false, volume: Float = 1, numLoop: Int = 0) {
        self.isPlaying = isPlaying
        self.volume = volume
        self.numLoop = numLoop
    }
}
