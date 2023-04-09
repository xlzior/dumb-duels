//
//  BulletSound.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 9/4/23.
//

import DuelKit
import Foundation

class BulletSound: Sound {
    var isPlaying = true
    var url: URL = Bundle.main.url(forResource: "bullet", withExtension: "mp3")!
    var volume: Float = 0.15
    var numLoop: Int = 0
}
