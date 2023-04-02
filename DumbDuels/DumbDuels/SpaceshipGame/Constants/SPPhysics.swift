//
//  SPPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

struct SPPhysics {
    static let spaceshipMass: CGFloat = 1.0
    static let spaceshipGravity = false
    static let spaceshipCor: CGFloat = 0.8
    static let spaceshipIsDynamic = true
    static let spaceshipZRotation = PhysicsEngineDefaults.zRotation
    static let spaceshipRotation = false
    static let spaceshipFriction = PhysicsEngineDefaults.friction
    static let spaceshipMovingDamping = 0.7
    static let spaceshipStaticDamping = 0.05
    static let spaceshipImpulse: CGVector = .zero
    static let spaceshipAngularImpulse: CGFloat = .zero

    static let rockMass: CGFloat = 10.0
    static let rockGravity = false
    static let rockCor: CGFloat = 0.8
    static let rockIsDynamic = true
    static let rockZRotation = PhysicsEngineDefaults.zRotation
    static let rockRotation = true
    static let rockFriction = PhysicsEngineDefaults.friction
    static let rockDamping = PhysicsEngineDefaults.linearDamping
    static let rockImpulse: CGVector = .zero
    static let rockAngularImpulse: CGFloat = .zero

    static let bulletMass: CGFloat = 1.0
    static let bulletGravity = false
    static let bulletCor: CGFloat = 0.8
    static let bulletIsDynamic = true
    static let bulletZRotation = PhysicsEngineDefaults.zRotation
    static let bulletRotation = true
    static let bulletFriction = PhysicsEngineDefaults.friction
    static let bulletDamping = PhysicsEngineDefaults.linearDamping
    static let bulletImpulse: CGVector = .zero
    static let bulletAngularImpulse: CGFloat = .zero

    static let powerupMass: CGFloat = 1.0
    static let powerupGravity = false
    static let powerupCor: CGFloat = 0.0
    static let powerupIsDynamic = false
    static let powerupZRotation = PhysicsEngineDefaults.zRotation
    static let powerupRotation = false
    static let powerupFriction = PhysicsEngineDefaults.friction
    static let powerupDamping = PhysicsEngineDefaults.linearDamping
    static let powerupImpulse: CGVector = .zero
    static let powerupAngularImpulse: CGFloat = .zero
}
