//
//  PhysicsEngineDefaults.swift
//  DuelKit
//
//  Created by Bryan Kwok on 17/3/23.
//

import CoreGraphics

public struct PhysicsEngineDefaults {
    public static let position = CGPoint.zero
    public static let zRotation = CGFloat.zero
    public static let mass: CGFloat = 1
    public static let velocity = CGVector.zero
    public static let affectedByGravity = true
    public static let linearDamping: CGFloat = 0.1
    public static let isDynamic = true
    public static let allowsRotation = true
    public static let restitution: CGFloat = 0.2
    public static let friction: CGFloat = 0.2
    public static let categoryBitMask: UInt32 = 0xFFFFFFFF
    public static let collisionBitMask: UInt32 = 0xFFFFFFFF
    public static let contactBitMask: UInt32 = 0x00000000
}
