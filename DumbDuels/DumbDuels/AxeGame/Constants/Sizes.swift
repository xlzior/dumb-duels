//
//  Sizes.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

struct Sizes {
    static let game = CGSize(width: 1_000, height: 650)
    static let player = CGSize(width: 80, height: 80)
    static let axe = CGSize(width: 40, height: 40)
    static let platform = CGSize(width: 200, height: 50)
    static let wall = CGSize(width: 1, height: game.height)

    static func axeOffsetFromPlayer(facing direction: FaceDirection) -> CGFloat {
        (Sizes.player.width / 2 + Sizes.axe.height / 2 + 1) * direction.rawValue
    }
}
