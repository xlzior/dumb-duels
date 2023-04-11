//
//  SOPositions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

struct SOPositions {
    private static let midX = Sizes.game.width / 2
    private static let midY = Sizes.game.height / 2
    private static let halfGoalWidth = SOSizes.goal.width / 2

    static let goals = [
        CGPoint(x: halfGoalWidth, y: midY),
        CGPoint(x: Sizes.game.width - halfGoalWidth, y: midY)
    ]

    private static let startingDistanceFromBall: CGFloat = 100

    static let players = [
        CGPoint(x: midX - startingDistanceFromBall, y: midY),
        CGPoint(x: midX + startingDistanceFromBall, y: midY)
    ]
    static let playerRotations: [CGFloat] = [0, Double.pi]
    static let playerFacing: [FaceDirection] = [.right, .left]

    static let ball = CGPoint(x: midX, y: midY)

    static let buffer = SOSizes.wallThickness / 2

    private static let topWallY = (Sizes.game.height - SOSizes.goal.height) / 4
    private static let bottomWallY = Sizes.game.height - topWallY

    static let walls: [CGPoint] = [
        CGPoint(x: midX, y: -buffer), // bottom
        CGPoint(x: midX, y: Sizes.game.height + buffer), // top
        CGPoint(x: SOSizes.goal.width - buffer, y: topWallY), // top left
        CGPoint(x: Sizes.game.width - SOSizes.goal.width + buffer, y: topWallY),// top right
        CGPoint(x: SOSizes.goal.width - buffer, y: bottomWallY),// bottom left
        CGPoint(x: Sizes.game.width - SOSizes.goal.width + buffer, y: bottomWallY)// bottom right
    ]
}
