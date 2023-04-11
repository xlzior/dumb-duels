//
//  SOSizes.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

struct SOSizes {
    static let goal = CGSize(width: 59, height: 183)
    static let goalThickness: CGFloat = 8

    static let player = CGSize(width: 50, height: 100)

    static let ball = CGSize(width: 40, height: 40)

    static let wallThickness: CGFloat = 200

    private static let sideWallHeight = (Sizes.game.height - goal.height) / 2

    static let walls = [
        CGSize(width: Sizes.game.width, height: wallThickness), // bottom
        CGSize(width: Sizes.game.width, height: wallThickness), // top
        CGSize(width: wallThickness, height: sideWallHeight), // top left
        CGSize(width: wallThickness, height: sideWallHeight), // top right
        CGSize(width: wallThickness, height: sideWallHeight), // bottom left
        CGSize(width: wallThickness, height: sideWallHeight) // bottom right
    ]
}
