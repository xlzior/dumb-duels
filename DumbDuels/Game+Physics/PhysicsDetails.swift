//
//  PhysicsDetails.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import Foundation

public struct PhysicsDetails {
    let mass: CGFloat
    let velocity: CGVector
    let affectedByGravity: Bool
    let linearDamping: CGFloat
    let isDynamic: Bool
    let allowsRotation: Bool
    let restitution: CGFloat
    let friction: CGFloat
    let categoryBitMask: UInt32
    let collisionBitMask: UInt32
    let contactTestBitMask: UInt32

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
                contactTestBitMask: UInt32 = 0x00000000) {
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
    }
}
