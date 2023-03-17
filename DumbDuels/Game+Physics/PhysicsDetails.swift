//
//  PhysicsDetails.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import Foundation

public struct PhysicsDetails {
    public let mass: CGFloat
    public let velocity: CGVector
    public let affectedByGravity: Bool
    public let linearDamping: CGFloat
    public let isDynamic: Bool
    public let allowsRotation: Bool
    public let restitution: CGFloat
    public let friction: CGFloat
    public let categoryBitMask: UInt32
    public let collisionBitMask: UInt32
    public let contactTestBitMask: UInt32
    public let zRotation: CGFloat

    public init(mass: CGFloat,
                velocity: CGVector,
                affectedByGravity: Bool = true,
                linearDamping: CGFloat = 0.1,
                isDynamic: Bool = true,
                allowsRotation: Bool = true,
                restitution: CGFloat = 0.2,
                friction: CGFloat = 0.2,
                categoryBitMask: UInt32 = 0xFFFFFFFF,
                collisionBitMask: UInt32 = 0xFFFFFFFF,
                contactTestBitMask: UInt32 = 0x00000000,
                zRotation: CGFloat = .zero) {
        self.mass = mass
        self.velocity = velocity
        self.affectedByGravity = affectedByGravity
        self.linearDamping = linearDamping
        self.isDynamic = isDynamic
        self.allowsRotation = allowsRotation
        self.restitution = restitution
        self.friction = friction
        self.categoryBitMask = categoryBitMask
        self.collisionBitMask = collisionBitMask
        self.contactTestBitMask = contactTestBitMask
        self.zRotation = zRotation
    }
}
