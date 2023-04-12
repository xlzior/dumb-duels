//
//  File.swift
//  
//
//  Created by Bryan Kwok on 12/4/23.
//

import Foundation

public struct PhysicsDetails {
    public var mass: CGFloat
    public var velocity: CGVector
    public var affectedByGravity: Bool
    public var linearDamping: CGFloat
    public var isDynamic: Bool
    public var allowsRotation: Bool
    public var restitution: CGFloat
    public var friction: CGFloat
    public var ownBitmask: UInt32
    public var collideBitmask: UInt32
    public var contactBitmask: UInt32
    public var zRotation: CGFloat
    public var impulse: CGVector
    public var angularImpulse: CGFloat

    public init(mass: CGFloat = 1, velocity: CGVector = CGVector.zero, affectedByGravity: Bool = true,
                linearDamping: CGFloat = 0.1, isDynamic: Bool = true, allowsRotation: Bool = true,
                restitution: CGFloat = 0.2, friction: CGFloat = 0.2, ownBitmask: UInt32 = 0xFFFFFFFF,
                collideBitmask: UInt32 = 0xFFFFFFFF, contactBitmask: UInt32 = 0x00000000,
                zRotation: CGFloat = CGFloat.zero, impulse: CGVector = CGVector.zero,
                angularImpulse: CGFloat = CGFloat.zero) {
        self.mass = mass
        self.velocity = velocity
        self.affectedByGravity = affectedByGravity
        self.linearDamping = linearDamping
        self.isDynamic = isDynamic
        self.allowsRotation = allowsRotation
        self.restitution = restitution
        self.friction = friction
        self.zRotation = zRotation
        self.impulse = impulse
        self.angularImpulse = angularImpulse
        self.ownBitmask = ownBitmask
        self.collideBitmask = collideBitmask
        self.contactBitmask = contactBitmask
    }
}
