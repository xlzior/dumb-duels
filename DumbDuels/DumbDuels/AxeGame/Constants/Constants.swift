//
//  Constants.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 17/3/23.
//

import CoreGraphics

enum Constants {
    static let minimumThrowStrength: CGFloat = 1.0
    static let maximumThrowStrength: CGFloat = 2.0
    static let throwStrengthChangeRate: CGFloat = 0.03
    static let throwForce = CGVector(dx: 600.0, dy: 600.0)
    static let jumpForce = CGVector(dx: 0.0, dy: 700.0)
}
