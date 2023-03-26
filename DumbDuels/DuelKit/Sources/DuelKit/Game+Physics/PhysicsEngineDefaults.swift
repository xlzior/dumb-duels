//
//  PhysicsEngineDefaults.swift
//  DuelKit
//
//  Created by Bryan Kwok on 17/3/23.
//

import CoreGraphics

struct PhysicsEngineDefaults {
    static let position = CGPoint.zero
    static let zRotation = CGFloat.zero
    static let mass: CGFloat = 1
    static let velocity = CGVector.zero
    static let affectedByGravity = true
    static let linearDamping: CGFloat = 0.1
    static let isDynamic = true
    static let allowsRotation = true
    static let restitution: CGFloat = 0.2
    static let friction: CGFloat = 0.2
    static let categoryBitMask: UInt32 = 0xFFFFFFFF
    static let collisionBitMask: UInt32 = 0xFFFFFFFF
    static let contactBitMask: UInt32 = 0x00000000
}
