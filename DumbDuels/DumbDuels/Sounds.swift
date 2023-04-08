//
//  Sounds.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 8/4/23.
//

import Foundation

struct Sounds {
    static let battleSound: URL = Bundle.main.url(forResource: "battle", withExtension: "mp3")!
    static let gameEndSound: URL = Bundle.main.url(forResource: "game-end", withExtension: "mp3")!
}
