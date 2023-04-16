//
//  TAPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit
import CoreGraphics

struct TAPhysics {
    static let tankPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        allowsRotation: false,
        restitution: 0.8,
        friction: 0,
        ownBitmask: TACollisions.tankBitmask,
        collideBitmask: TACollisions.tankCollideBitmask,
        contactBitmask: TACollisions.tankContactBitmask
    )

    static func getCannonballPhysicsDetails(with velocity: CGVector) -> PhysicsDetails {
        PhysicsDetails(
            velocity: velocity,
            affectedByGravity: false,
            linearDamping: 0,
            allowsRotation: false,
            friction: 0,
            ownBitmask: TACollisions.cannonballBitmask,
            collideBitmask: TACollisions.cannonballCollideBitmask,
            contactBitmask: TACollisions.cannonballContactBitmask
        )
    }

    static let wallPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 1,
        friction: 0,
        ownBitmask: TACollisions.wallBitmask,
        collideBitmask: TACollisions.wallContactBitmask,
        contactBitmask: TACollisions.wallCollideBitmask
    )

    static let sideWallPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 1,
        friction: 0,
        ownBitmask: TACollisions.sideWallBitmask,
        collideBitmask: TACollisions.sideWallCollideBitmask,
        contactBitmask: TACollisions.sideWallContactBitmask
    )
}
