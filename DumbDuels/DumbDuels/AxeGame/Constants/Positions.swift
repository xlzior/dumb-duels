//
//  Positions.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics
import DuelKit

struct Positions {
    static let players: [CGPoint] = [
        CGPoint(x: 200, y: 300),
        CGPoint(x: 800, y: 300)
    ]

    static let walls: [CGPoint] = [
        CGPoint(x: 2, y: Sizes.game.height / 2),
        CGPoint(x: Sizes.game.width - 2, y: Sizes.game.height / 2),
        CGPoint(x: Sizes.game.width / 2, y: Sizes.game.height - 2)
    ]

    static let axes: [CGPoint] = [
        CGPoint(x: 261, y: 300),
        CGPoint(x: 739, y: 300)
    ]

    static let pegs: [CGPoint] = [
        CGPoint(x: 400, y: 375),
        CGPoint(x: 600, y: 375)
    ]

    static let lava = CGPoint(x: Sizes.game.width / 2, y: Sizes.lava.height / 2)

    static let text = CGPoint(x: Sizes.game.width / 2, y: Sizes.game.height * 2 / 3)
}
