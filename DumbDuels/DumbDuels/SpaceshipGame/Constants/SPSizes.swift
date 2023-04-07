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

    // TODO: this seems like it should be in SPPositions
    // TODO: maybe move to duelkit?
    static func getSpaceshipResetPositions() -> (CGPoint, CGPoint) {
        let spaceshipDimension = max(spaceship.width, spaceship.height)
        let safeArea = Sizes.gameRect.insetBy(dx: spaceshipDimension / 2, dy: spaceshipDimension / 2)
        var firstPosition = CGPoint.random(within: safeArea)
        var secondPosition = CGPoint.random(within: safeArea)
        while secondPosition.distanceTo(firstPosition) < spaceshipDimension {
            secondPosition = CGPoint.random(within: safeArea)
        }
        return (firstPosition, secondPosition)
    }
}
