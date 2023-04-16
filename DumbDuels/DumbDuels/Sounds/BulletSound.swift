//
//  BulletSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class BulletSound: Sound {
    var url: URL = Bundle.main.url(forResource: "bullet", withExtension: "mp3")!

    var isPlaying: Bool
    var volume: Float
    var numLoop: Int

    init(isPlaying: Bool = false, volume: Float = 0.15, numLoop: Int = 0) {
        self.isPlaying = isPlaying
        self.volume = volume
        self.numLoop = numLoop
    }
}
