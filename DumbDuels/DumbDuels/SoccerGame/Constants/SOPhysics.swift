//
//  SOPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

struct SOPhysics {
    static let playerPhysicsDetails = PhysicsDetails(
        mass: 100,
        affectedByGravity: false,
        linearDamping: 0,
        allowsRotation: false,
        restitution: 0,
        friction: 0,
        ownBitmask: SOCollisions.playerBitmask,
        collideBitmask: SOCollisions.playerCollideBitmask,
        contactBitmask: SOCollisions.playerContactBitmask
    )

    static let ballPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0.5,
        restitution: 0.8,
        friction: 0,
        ownBitmask: SOCollisions.ballBitmask,
        collideBitmask: SOCollisions.ballCollideBitmask,
        contactBitmask: SOCollisions.ballContactBitmask
    )

    static let goalPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        friction: 0,
        ownBitmask: SOCollisions.goalBitmask,
        collideBitmask: SOCollisions.goalCollideBitmask,
        contactBitmask: SOCollisions.goalContactBitmask
    )

    static let goalSidePhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        friction: 0,
        ownBitmask: SOCollisions.goalSideBitmask,
        collideBitmask: SOCollisions.goalSideCollideBitmask,
        contactBitmask: SOCollisions.goalSideContactBitmask
    )

    static let goalBackPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0.8,
        friction: 0,
        ownBitmask: SOCollisions.goalBackBitmask,
        collideBitmask: SOCollisions.goalBackCollideBitmask,
        contactBitmask: SOCollisions.goalBackContactBitmask
    )

    static let wallPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 1,
        friction: 0,
        ownBitmask: SOCollisions.wallBitmask,
        collideBitmask: SOCollisions.wallContactBitmask,
        contactBitmask: SOCollisions.wallCollideBitmask
    )
}
