//
//  AXPhysics.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import CoreGraphics
import DuelKit

struct AXPhysics {
    static let playerPhysicsDetails = PhysicsDetails(
        allowsRotation: false,
        restitution: 0,
        ownBitmask: AXCollisions.playerBitmask,
        collideBitmask: AXCollisions.playerCollideBitmask,
        contactBitmask: AXCollisions.playerContactBitmask
    )

    static let axePhysicsDetails = PhysicsDetails(
        restitution: 0.1,
        ownBitmask: AXCollisions.axeBitmask,
        collideBitmask: AXCollisions.axeCollideBitmask,
        contactBitmask: AXCollisions.axeContactBitmask
    )

    static let platformPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0,
        ownBitmask: AXCollisions.platformBitmask,
        collideBitmask: AXCollisions.platformCollideBitmask,
        contactBitmask: AXCollisions.platformContactBitmask
    )

    static let pegPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.7,
        ownBitmask: AXCollisions.pegBitmask,
        collideBitmask: AXCollisions.pegCollideBitmask,
        contactBitmask: AXCollisions.pegContactBitmask
    )

    static let lavaPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        ownBitmask: AXCollisions.lavaBitmask,
        collideBitmask: AXCollisions.lavaCollideBitmask,
        contactBitmask: AXCollisions.lavaContactBitmask
    )

    static let wallPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        ownBitmask: AXCollisions.wallBitmask,
        collideBitmask: AXCollisions.wallCollideBitmask,
        contactBitmask: AXCollisions.wallContactBitmask
    )

    static func getAxeParticlePhysicsDetails(with initialImpulse: CGVector) -> PhysicsDetails {
        PhysicsDetails(
            allowsRotation: false,
            restitution: 0,
            ownBitmask: AXCollisions.axeParticleBitmask,
            collideBitmask: AXCollisions.axeParticleCollideBitmask,
            contactBitmask: AXCollisions.axeParticleContactBitmask,
            impulse: initialImpulse
        )
    }
}
