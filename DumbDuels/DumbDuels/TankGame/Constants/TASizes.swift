//
//  TASizes.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

struct TASizes {
    static let wallThickness: CGFloat = 20
    static let wallLength: CGFloat = 160

    static let walls = [
        CGSize(width: wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: 2 * wallLength),
        CGSize(width: wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: wallLength),
        CGSize(width: 2 * wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: wallLength)
    ]

    static let sideWalls = [
        CGSize(width: 1, height: Sizes.game.height),
        CGSize(width: 1, height: Sizes.game.height),
        CGSize(width: Sizes.game.width, height: 1),
        CGSize(width: Sizes.game.width, height: 1)
    ]

    static let cannonball = CGSize(width: 25, height: 25)

    static let tank = CGSize(width: 75, height: 75)
}
