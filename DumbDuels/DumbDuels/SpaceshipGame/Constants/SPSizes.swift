//
//  SPSizes.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

struct SPSizes {
    static let spaceship = CGSize(width: 80, height: 60)
    static let rock = CGSize(width: 60, height: 60)
    static let bullet = CGSize(width: 40, height: 10)
    static let powerup = CGSize(width: 60, height: 60)
    static let accelerationParticle = CGSize(width: 8, height: 8)
    static let spaceshipDestroyParticle = CGSize(width: 10, height: 10)
    static let star = CGSize(width: 11, height: 11)

    static func getSpaceshipResetPositions() -> (CGPoint, CGPoint) {
        let spaceshipDimension = max(spaceship.width, spaceship.height)
        let boundingBox = CGSize(width: Sizes.game.width - spaceshipDimension,
                                 height: Sizes.game.height - spaceshipDimension)
        var firstPosition = CGPoint.random(within: boundingBox)
        firstPosition += CGPoint(x: spaceshipDimension / 2, y: spaceshipDimension / 2)
        var secondPosition = CGPoint.random(within: boundingBox)
        secondPosition += CGPoint(x: spaceshipDimension / 2, y: spaceshipDimension / 2)
        while secondPosition.distanceTo(firstPosition) < spaceshipDimension {
            secondPosition = CGPoint.random(within: boundingBox)
            secondPosition += CGPoint(x: spaceshipDimension / 2, y: spaceshipDimension / 2)
        }
        return (firstPosition, secondPosition)
    }
}
