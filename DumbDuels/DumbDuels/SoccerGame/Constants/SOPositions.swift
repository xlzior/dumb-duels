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
        CGPoint(x: Sizes.game.width - halfGoalWidth, y: midY),
        CGPoint(x: halfGoalWidth, y: midY)
    ]
    static let goalFacing: [FaceDirection] = [.left, .right]

    private static let startingDistanceFromBall: CGFloat = 100

    static let players = [
        CGPoint(x: midX - startingDistanceFromBall, y: midY),
        CGPoint(x: midX + startingDistanceFromBall, y: midY)
    ]
    static let playerRotations: [CGFloat] = [Double.pi, 0]

    static let ball = CGPoint(x: midX, y: midY)

    static let buffer = SOSizes.wallThickness / 2

    private static let topWallY = (Sizes.game.height - SOSizes.goal.height) / 4
    private static let bottomWallY = Sizes.game.height - topWallY

    private static let field = Sizes.gameRect.insetBy(dx: SOSizes.goal.width, dy: 0)

    static let walls: [CGPoint] = [
        CGPoint(x: midX, y: field.minY - buffer), // bottom
        CGPoint(x: midX, y: field.maxY + buffer), // top
        CGPoint(x: field.minX - buffer, y: topWallY), // top left
        CGPoint(x: field.maxX + buffer, y: topWallY),// top right
        CGPoint(x: field.minX - buffer, y: bottomWallY),// bottom left
        CGPoint(x: field.maxX + buffer, y: bottomWallY), // bottom right
        CGPoint(x: field.minX, y: field.minY),
        CGPoint(x: field.minX, y: field.maxY),
        CGPoint(x: field.maxX, y: field.minY),
        CGPoint(x: field.maxX, y: field.maxY)
    ]

    static let wallRotations: [CGFloat] = [
        0, 0, 0, 0, 0, 0,
        Double.pi / 4, Double.pi / 4, Double.pi / 4, Double.pi / 4
    ]
}
