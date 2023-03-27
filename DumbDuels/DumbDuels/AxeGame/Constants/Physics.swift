//
//  Physics.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

struct Physics {
    static let jumpImpulse = CGVector(dx: 0.0, dy: -100)
    static let axeImpulse = CGVector(dx: 0.0, dy: 1_000)

    // Player physics constants
    static let playerMass: CGFloat = 1.0
    static let playerGravity = true
    static let playerCor: CGFloat = 0.0
    static let playerIsDynamic = true
    static let playerZRotation = PhysicsEngineDefaults.zRotation
    static let playerRotation = false
    static let playerFriction = PhysicsEngineDefaults.friction
    static let playerDamping = PhysicsEngineDefaults.linearDamping
    static let playerImpulse: CGVector = .zero
    static let playerAngularImpulse: CGFloat = .zero

    // Axe physics constants
    static let axeMass: CGFloat = 1.0
    static let axeGravity = true
    static let axeCor: CGFloat = 0.1
    static let axeIsDynamic = true
    static let axeZRotation = PhysicsEngineDefaults.zRotation
    static let axeRotation = true
    static let axeFriction = PhysicsEngineDefaults.friction
    static let axeDamping = PhysicsEngineDefaults.linearDamping
    static let axeInitialImpulse: CGVector = .zero
    static let axeInitialAngularImpulse: CGFloat = .zero

    // Platform physics constants
    static let platformMass: CGFloat = 1.0
    static let platformGravity = false
    static let platformCor: CGFloat = 0.0
    static let platformIsDynamic = false
    static let platformZRotation = PhysicsEngineDefaults.zRotation
    static let platformRotation = false
    static let platformFriction = PhysicsEngineDefaults.friction
    static let platformDamping = PhysicsEngineDefaults.linearDamping
    static let platformImpulse: CGVector = .zero
    static let platformAngularImpulse: CGFloat = .zero

    // Peg physics constants
    static let pegMass: CGFloat = 1.0
    static let pegGravity = false
    static let pegCor: CGFloat = 0.1
    static let pegIsDynamic = false
    static let pegZRotation = PhysicsEngineDefaults.zRotation
    static let pegRotation = false
    static let pegFriction = PhysicsEngineDefaults.friction
    static let pegDamping = PhysicsEngineDefaults.linearDamping
    static let pegImpulse: CGVector = .zero
    static let pegAngularImpulse: CGFloat = .zero

    // Wall physics constants
    static let wallMass: CGFloat = 1.0
    static let wallGravity = false
    static let wallCor: CGFloat = 0.8
    static let wallIsDynamic = false
    static let wallZRotation = PhysicsEngineDefaults.zRotation
    static let wallRotation = false
    static let wallFriction = PhysicsEngineDefaults.friction
    static let wallDamping = PhysicsEngineDefaults.linearDamping
    static let wallImpulse: CGVector = .zero
    static let wallAngularImpulse: CGFloat = .zero
}
