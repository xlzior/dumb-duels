//
//  SPPhysics.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

struct SPPhysics {
    static let spaceshipMovingDamping = 0.7
    static let spaceshipStaticDamping = 0.05

    static let spaceshipPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        linearDamping: spaceshipStaticDamping,
        allowsRotation: false,
        restitution: 0.8,
        ownBitmask: SPCollisions.spaceshipBitmask,
        collideBitmask: SPCollisions.spaceshipCollideBitmask,
        contactBitmask: SPCollisions.spaceshipContactBitmask
    )

    static func getRockPhysicsDetails(with initialImpulse: CGVector) -> PhysicsDetails {
        PhysicsDetails(
            mass: 10,
            affectedByGravity: false,
            restitution: 0.8,
            ownBitmask: SPCollisions.rockBitmask,
            collideBitmask: SPCollisions.rockCollideBitmask,
            contactBitmask: SPCollisions.rockContactBitmask,
            impulse: initialImpulse
        )
    }

    static func getBulletPhysicsDetails(with initialImpulse: CGVector) -> PhysicsDetails { PhysicsDetails(
            affectedByGravity: false,
            restitution: 0.8,
            ownBitmask: SPCollisions.bulletBitmask,
            collideBitmask: SPCollisions.bulletCollideBitmask,
            contactBitmask: SPCollisions.bulletContactBitmask,
            impulse: initialImpulse
        )
    }

    static let powerupPhysicsDetails = PhysicsDetails(
        affectedByGravity: false,
        isDynamic: false,
        allowsRotation: false,
        restitution: 0,
        ownBitmask: SPCollisions.powerupBitmask,
        collideBitmask: SPCollisions.powerupCollideBitmask,
        contactBitmask: SPCollisions.powerupContactBitmask
    )
}
