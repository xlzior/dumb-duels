//
//  ExplodeSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 10/4/23.
//

import DuelKit
import Foundation

class ExplodeSound: Sound {
    var url: URL = Bundle.main.url(forResource: "explode", withExtension: "mp3")!

    var isPlaying: Bool
    var volume: Float
    var numLoop: Int

    init(isPlaying: Bool = false, volume: Float = 1, numLoop: Int = 0) {
        self.isPlaying = isPlaying
        self.volume = volume
        self.numLoop = numLoop
    }
}
