//
//  PhysicsEngineDefaults.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import CoreGraphics

struct PhysicsEngineDefaults {
    static let position: CGPoint = CGPoint.zero
    static let zRotation: CGFloat = CGFloat.zero
    static let mass: CGFloat = 1
    static let velocity: CGVector = CGVector.zero
    static let affectedByGravity: Bool = true
    static let linearDamping: CGFloat = 0.1
    static let isDynamic: Bool = true
    static let allowsRotation: Bool = true
    static let restitution: CGFloat = 0.2
    static let friction: CGFloat = 0.2
    static let categoryBitMask: UInt32 = 0xFFFFFFFF
    static let collisionBitMask: UInt32 = 0xFFFFFFFF
    static let contactBitMask: UInt32 = 0x00000000
}
