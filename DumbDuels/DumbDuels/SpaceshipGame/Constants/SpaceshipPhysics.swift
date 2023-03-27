//
//  SpaceshipPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

struct SpaceshipPhysics {
    static let spaceshipMass: CGFloat = 1.0
    static let spaceshipGravity = false
    static let spaceshipCor: CGFloat = 0.8
    static let spaceshipIsDynamic = true
    static let spaceshipZRotation = PhysicsEngineDefaults.zRotation
    static let spaceshipRotation = true
    static let spaceshipFriction = PhysicsEngineDefaults.friction
    static let spaceshipDamping = PhysicsEngineDefaults.linearDamping
    static let spaceshipImpulse: CGVector = .zero
    static let spaceshipAngularImpulse: CGFloat = .zero

}
