//
//  TASizes.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

struct TASizes {
    static let wallThickness: CGFloat = 25
    static let wallLength: CGFloat = 160

    static let walls = [
        CGSize(width: wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: 2 * wallLength),
        CGSize(width: wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: wallLength),
        CGSize(width: 2 * wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: wallLength)
    ]

    static let sideWallThickness: CGFloat = 50

    static let sideWalls = [
        CGSize(width: sideWallThickness, height: Sizes.game.height),
        CGSize(width: sideWallThickness, height: Sizes.game.height),
        CGSize(width: Sizes.game.width, height: sideWallThickness),
        CGSize(width: Sizes.game.width, height: sideWallThickness)
    ]

    static let cannonball = CGSize(width: 20, height: 20)
    static let cannonballFire = CGSize(width: 30, height: 20)

    static let tank = CGSize(width: 75, height: 75)
}
