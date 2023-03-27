//
//  Constants.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 17/3/23.
//

import CoreGraphics

enum Constants {
    static let defaultThrowStrength: CGFloat = 1.0
    static let minimumThrowStrength: CGFloat = 1.0
    static let maximumThrowStrength: CGFloat = 2.0
    static let chargingTime: Double = 1.0

    static let throwForce = CGVector(dx: 600.0, dy: 600.0)
    static let throwAngularForce: CGFloat = 0.1
    static let jumpForce = CGVector(dx: 0.0, dy: 700.0)
}
