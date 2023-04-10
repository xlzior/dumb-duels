//
//  Sounds.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 8/4/23.
//

import DuelKit

struct Sounds {
    static func battleSound() -> BattleSound { BattleSound(isPlaying: true) }
    static func gameEndSound() -> GameEndSound { GameEndSound(isPlaying: true) }
}
