//
//  BattleSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class BattleSound: Sound {
    var isPlaying = true
    var url: URL = Bundle.main.url(forResource: "battle", withExtension: "mp3")!
    var volume: Float = 0.7
    var numLoop: Int = 0
}
