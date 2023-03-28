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
    static let platformAmplitude = 5.0
    static let platformPeriod = 3.0
    static let platformDisplacement = 0.0

    // Peg oscillation constants
    static let pegAmplitude = 5.0
    static let pegPeriod = 3.0
    static let pegDisplacement = 0.0
}
