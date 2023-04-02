//
//  SPConstants.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import Foundation

enum SPConstants {
    static let rotationSpeed: CGFloat = 0.04
    static let rotationStoppedInterval: TimeInterval = 1.0

    static let propulsionForce: CGFloat = 400.0

    static let powerupSpawnInterval: TimeInterval = 5.0
    static let maxPowerUpsOnField: Int = 3

    static let bulletForce: CGFloat = 600.0
    static let gunInterval: TimeInterval = 1.5
    static let numBullets = 6

    static let rockForce: CGFloat = 3_000.0

    static let bombNumBullets: Int = 8
    static let bombRadius: CGFloat = 25.0

    static let winningScore = 5
}
