//
//  GameEndSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class GameEndSound: Sound {
    var isPlaying = true
    var url: URL = Bundle.main.url(forResource: "game-end", withExtension: "mp3")!
    var volume: Float = 1
    var numLoop: Int = 0

}
