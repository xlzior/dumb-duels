//
//  SoccerCrowdSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 12/4/23.
//

import DuelKit
import Foundation

class SoccerCrowdSound: Sound {
    var url: URL = Bundle.main.url(forResource: "soccer-crowd", withExtension: "mp3")!

    var isPlaying: Bool
    var volume: Float
    var numLoop: Int

    init(isPlaying: Bool = true, volume: Float = 0.2, numLoop: Int = -1) {
        self.isPlaying = isPlaying
        self.volume = volume
        self.numLoop = numLoop
    }
}
