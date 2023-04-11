//
//  SOPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

struct SOPhysics {
    static let playerMass: CGFloat = 100.0
    static let playerGravity = false
    static let playerCor: CGFloat = 0
    static let playerIsDynamic = true
    static let playerZRotation = PhysicsEngineDefaults.zRotation
    static let playerRotation = false
    static let playerFriction: CGFloat = 0
    static let playerStaticDamping: CGFloat = 0
    static let playerImpulse: CGVector = .zero
    static let playerAngularImpulse: CGFloat = .zero

    static let ballMass: CGFloat = 1.0
    static let ballGravity = false
    static let ballCor: CGFloat = 0.8
    static let ballIsDynamic = true
    static let ballZRotation = PhysicsEngineDefaults.zRotation
    static let ballRotation = true
    static let ballFriction: CGFloat = 0
    static let ballStaticDamping: CGFloat = 0.1
    static let ballImpulse: CGVector = .zero
    static let ballAngularImpulse: CGFloat = .zero

    static let goalMass: CGFloat = 1.0
    static let goalGravity = false
    static let goalCor: CGFloat = 0.8
    static let goalIsDynamic = false
    static let goalZRotation = PhysicsEngineDefaults.zRotation
    static let goalRotation = false
    static let goalFriction: CGFloat = 0
    static let goalStaticDamping: CGFloat = 0
    static let goalImpulse: CGVector = .zero
    static let goalAngularImpulse: CGFloat = .zero

    static let wallMass: CGFloat = 1.0
    static let wallGravity = false
    static let wallCor: CGFloat = 0.8
    static let wallIsDynamic = false
    static let wallZRotation = PhysicsEngineDefaults.zRotation
    static let wallRotation = false
    static let wallFriction: CGFloat = 0
    static let wallStaticDamping: CGFloat = 0
    static let wallImpulse: CGVector = .zero
    static let wallAngularImpulse: CGFloat = .zero
}
