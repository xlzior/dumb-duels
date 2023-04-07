//
//  TAPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit
import CoreGraphics

struct TAPhysics {
    static let tankMass: CGFloat = 1.0
    static let tankGravity = false
    static let tankCor: CGFloat = 0.8
    static let tankIsDynamic = true
    static let tankZRotation = PhysicsEngineDefaults.zRotation
    static let tankRotation = false
    static let tankFriction = PhysicsEngineDefaults.friction
    static let tankMovingDamping: CGFloat = 0
    static let tankStaticDamping: CGFloat = 0
    static let tankImpulse: CGVector = .zero
    static let tankAngularImpulse: CGFloat = .zero

    static let cannonballMass: CGFloat = 1.0
    static let cannonballGravity = false
    static let cannonballCor: CGFloat = 1.0
    static let cannonballIsDynamic = true
    static let cannonballZRotation = PhysicsEngineDefaults.zRotation
    static let cannonballRotation = false
    static let cannonballFriction = PhysicsEngineDefaults.friction
    static let cannonballMovingDamping: CGFloat = 0
    static let cannonballStaticDamping: CGFloat = 0
    static let cannonballImpulse: CGVector = .zero
    static let cannonballAngularImpulse: CGFloat = .zero

    static let wallMass: CGFloat = 1.0
    static let wallGravity = false
    static let wallCor: CGFloat = 1.0
    static let wallIsDynamic = false
    static let wallZRotation = PhysicsEngineDefaults.zRotation
    static let wallRotation = false
    static let wallFriction = PhysicsEngineDefaults.friction
    static let wallMovingDamping: CGFloat = 0
    static let wallStaticDamping: CGFloat = 0
    static let wallImpulse: CGVector = .zero
    static let wallAngularImpulse: CGFloat = .zero

    static let sideWallMass: CGFloat = 1.0
    static let sideWallGravity = false
    static let sideWallCor: CGFloat = 1.0
    static let sideWallIsDynamic = false
    static let sideWallZRotation = PhysicsEngineDefaults.zRotation
    static let sideWallRotation = false
    static let sideWallFriction = PhysicsEngineDefaults.friction
    static let sideWallMovingDamping: CGFloat = 0
    static let sideWallStaticDamping: CGFloat = 0
    static let sideWallImpulse: CGVector = .zero
    static let sideWallAngularImpulse: CGFloat = .zero
}
