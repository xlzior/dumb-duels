//
//  AXPhysics.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import CoreGraphics
import DuelKit

struct AXPhysics {
    // Player physics details
    static let playerPhysicsDetails = PhysicsDetails(
        mass: 1,
        allowsRotation: false,
        restitution: 0,
        ownBitmask: AXCollisions.playerBitmask,
        collideBitmask: AXCollisions.playerCollideBitmask,
        contactBitmask: AXCollisions.playerContactBitmask
    )

    // Axe physics details
    static let axePhysicsDetails = PhysicsDetails(
        restitution: 0.1,
        ownBitmask: AXCollisions.axeBitmask,
        collideBitmask: AXCollisions.axeCollideBitmask,
        contactBitmask: AXCollisions.axeContactBitmask
    )

    // Platform physics details
    static let platformPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0,
        ownBitmask: AXCollisions.platformBitmask,
        collideBitmask: AXCollisions.platformCollideBitmask,
        contactBitmask: AXCollisions.platformContactBitmask
    )

    // Peg physics details
    static let pegPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.7,
        ownBitmask: AXCollisions.pegBitmask,
        collideBitmask: AXCollisions.pegCollideBitmask,
        contactBitmask: AXCollisions.pegContactBitmask
    )

    // Lava physics details
    static let lavaPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        ownBitmask: AXCollisions.lavaBitmask,
        collideBitmask: AXCollisions.lavaCollideBitmask,
        contactBitmask: AXCollisions.lavaContactBitmask
    )

    // Wall physics physics details
    static let wallPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        ownBitmask: AXCollisions.wallBitmask,
        collideBitmask: AXCollisions.wallCollideBitmask,
        contactBitmask: AXCollisions.wallContactBitmask
    )

    // Axe particle physics details
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
