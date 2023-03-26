//
//  Sizes.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics
import DuelKit

extension Sizes {
    static let player = CGSize(width: 80, height: 80)
    static let axe = CGSize(width: 40, height: 40)
    static let platform = CGSize(width: 200, height: 50)
    static let walls = [CGSize(width: 1, height: Sizes.game.height),
                        CGSize(width: 1, height: Sizes.game.height),
                        CGSize(width: Sizes.game.width, height: 1)]
    static let peg = CGSize(width: 30, height: 30)

    static func axeOffsetFromPlayer(facing direction: FaceDirection) -> CGFloat {
        (Sizes.player.width / 2 + Sizes.axe.height / 2 + 1) * direction.rawValue
    }
}
