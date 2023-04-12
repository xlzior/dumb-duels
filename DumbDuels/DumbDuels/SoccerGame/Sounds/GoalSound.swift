//
//  GoalSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 12/4/23.
//

import DuelKit
import Foundation

class GoalSound: Sound {
    var url: URL = Bundle.main.url(forResource: "goal", withExtension: "mp3")!

    var isPlaying: Bool
    var volume: Float
    var numLoop: Int

    init(isPlaying: Bool = true, volume: Float = 1, numLoop: Int = 0) {
        self.isPlaying = isPlaying
        self.volume = volume
        self.numLoop = numLoop
    }
}
