//
//  CollideSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 10/4/23.
//

import DuelKit
import Foundation

class CollideSound: Sound {
    var isPlaying = false
    var url: URL = Bundle.main.url(forResource: "collide", withExtension: "mp3")!
    var volume: Float = 1
    var numLoop: Int = 0
}
