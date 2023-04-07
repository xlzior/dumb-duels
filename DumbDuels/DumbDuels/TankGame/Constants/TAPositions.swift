//
//  TAPositions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

struct TAPositions {
    static let walls = [
        CGPoint(x: 225, y: 450),
        CGPoint(x: 300, y: 300),
        CGPoint(x: 525, y: 550),
        CGPoint(x: 600, y: 475),
        CGPoint(x: 700, y: 100),
        CGPoint(x: 700, y: 175)
    ]

    static let sideWalls: [CGPoint] = [
        CGPoint(x: 2, y: Sizes.game.height / 2),
        CGPoint(x: Sizes.game.width - 2, y: Sizes.game.height / 2),
        CGPoint(x: Sizes.game.width / 2, y: Sizes.game.height - 2),
        CGPoint(x: Sizes.game.width / 2, y: 2)
    ]

    static let tanks = [
        CGPoint(x: 100, y: 100),
        CGPoint(x: 900, y: 550)
    ]
}
