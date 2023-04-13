//
//  TTPositions.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

struct TTPositions {
    static let wallBuffer = TTSizes.wallSize.width / 2

    static let walls: [CGPoint] = [
        CGPoint(x: -wallBuffer, y: Sizes.game.height / 2),
        CGPoint(x: Sizes.game.width + wallBuffer, y: Sizes.game.height / 2)
    ]

    static let separator = CGPoint(x: Sizes.game.width / 2, y: Sizes.game.height / 2)

    static let platforms: [CGPoint] = [
        CGPoint(x: Sizes.game.width / 4, y: Sizes.game.height / 10),
        CGPoint(x: 3 * Sizes.game.width / 4, y: Sizes.game.height / 10)
    ]

    static let player1BlockSpawn = CGPoint(x: Sizes.game.width / 4, y: Sizes.game.height)
    static let player2BlockSpawn = CGPoint(x: 3 * Sizes.game.width / 4, y: Sizes.game.height)

    static let playerRanges = [
        CGRect(x: 0, y: 0, width: Sizes.game.width / 2, height: Sizes.game.height),
        CGRect(x: Sizes.game.width / 2, y: 0, width: Sizes.game.width / 2, height: Sizes.game.height)
    ]

    static func getScoreLinePositions() -> [CGPoint] {
        // there are 3 score lines at different levels
        let scoreYPositions: [CGFloat] = [
            Sizes.game.height / 4,
            Sizes.game.height / 3,
            Sizes.game.height / 2
        ]
        // just left or right
        let playerXPositions: [CGFloat] = [
            Sizes.game.width / 4,
            3 * Sizes.game.width / 4
        ]

        var scoreLinePositions: [CGPoint] = []
        for yPosition in scoreYPositions {
            for xPosition in playerXPositions {
                scoreLinePositions.append(CGPoint(x: xPosition, y: yPosition))
            }
        }

        return scoreLinePositions
    }
}
