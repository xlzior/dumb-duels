//
//  TTPhysics.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import DuelKit
import CoreGraphics

struct TTPhysics {
    static let platformPhysicsDetails = PhysicsDetails(
        mass: 100,
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0,
        friction: 0.1,
        ownBitmask: TTCollisions.platformBitmask,
        collideBitmask: TTCollisions.platformCollideBitmask,
        contactBitmask: TTCollisions.platformContactBitmask
    )

    static let wallPhysicsDetails = PhysicsDetails(
        mass: 100,
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0,
        friction: 0.1,
        ownBitmask: TTCollisions.wallBitmask,
        collideBitmask: TTCollisions.wallCollideBitmask,
        contactBitmask: TTCollisions.wallContactBitmask
    )

    static let bottomBoundaryPhysicsDetails = PhysicsDetails(
        mass: 100,
        affectedByGravity: false,
        linearDamping: 0,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0,
        friction: 0.1,
        ownBitmask: TTCollisions.bottomBoundaryBitmask,
        collideBitmask: TTCollisions.bottomBoundaryCollideBitmask,
        contactBitmask: TTCollisions.bottomBoundaryContactBitmask
    )

    static let controlblockGravity = false
    static let landedBlockGravity = true
    // Necessary because whne block is falling, it should stick to platform
    // But at the same time we want blocks that are landed to bounce off another block
    static let controlBlockCor: CGFloat = 0.0
    static let landedBlockCor: CGFloat = 0.2

    static func getBlockPhysicsDetails(of mass: CGFloat) -> PhysicsDetails {
        PhysicsDetails(
            mass: mass,
            velocity: CGVector(dx: 0, dy: -100),
            affectedByGravity: controlblockGravity,
            linearDamping: 0,
            restitution: controlBlockCor,
            friction: 0.1,
            ownBitmask: TTCollisions.controlBlockBitmask,
            collideBitmask: TTCollisions.controlBlockCollideBitmask,
            contactBitmask: TTCollisions.controlBlockContactBitmask
        )
    }
}
