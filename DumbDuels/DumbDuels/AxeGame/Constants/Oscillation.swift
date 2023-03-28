//
//  Oscillation.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 28/3/23.
//

import Foundation

struct Oscillation {
    static let horizontalAxis = CGVector(dx: 1, dy: 0)
    static let verticalAxis = CGVector(dx: 0, dy: 1)

    // Platform oscillation constants
    static let platformAmplitude = [100.0, 100.0]
    static let platformPeriod = [4.0, 4.0]
    static let platformDisplacement = [0.0, Double.pi]

    // Peg oscillation constants
    static let pegAmplitude = [80.0, 60.0]
    static let pegPeriod = [3.0, 2.0]
    static let pegDisplacement = 0.0
}
