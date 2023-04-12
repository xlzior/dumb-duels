//
//  TTPhysicsCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

class TTPhysicsCreator {
    func createPlatform(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: TTPhysics.platformMass,
                         velocity: .zero,
                         affectedByGravity: TTPhysics.platformGravity,
                         linearDamping: TTPhysics.platformLinearDamping,
                         isDynamic: TTPhysics.platformIsDynamic,
                         allowsRotation: TTPhysics.platformRotation,
                         restitution: TTPhysics.platformCor,
                         friction: TTPhysics.platformFriction,
                         ownBitmask: TTCollisions.platformBitmask,
                         collideBitmask: TTCollisions.platformCollideBitmask,
                         contactBitmask: TTCollisions.platformContactBitmask,
                         zRotation: TTPhysics.platformZRotation,
                         impulse: TTPhysics.platformImpulse,
                         angularImpulse: TTPhysics.platformAngularImpulse)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: TTPhysics.wallMass,
                         velocity: .zero,
                         affectedByGravity: TTPhysics.wallGravity,
                         linearDamping: TTPhysics.wallLinearDamping,
                         isDynamic: TTPhysics.wallIsDynamic,
                         allowsRotation: TTPhysics.wallRotation,
                         restitution: TTPhysics.wallCor,
                         friction: TTPhysics.wallFriction,
                         ownBitmask: TTCollisions.wallBitmask,
                         collideBitmask: TTCollisions.wallCollideBitmask,
                         contactBitmask: TTCollisions.wallContactBitmask,
                         zRotation: TTPhysics.wallZRotation,
                         impulse: TTPhysics.wallImpulse,
                         angularImpulse: TTPhysics.wallAngularImpulse)
    }

    func createBlock(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: TTPhysics.blockMass,
                         velocity: TTConstants.blockInitialVelocity,
                         affectedByGravity: TTPhysics.controlblockGravity,
                         linearDamping: TTPhysics.blockLinearDamping,
                         isDynamic: TTPhysics.blockIsDynamic,
                         allowsRotation: TTPhysics.blockRotation,
                         restitution: TTPhysics.controlBlockCor,
                         friction: TTPhysics.blockFriction,
                         ownBitmask: TTCollisions.controlBlockBitmask,
                         collideBitmask: TTCollisions.controlBlockCollideBitmask,
                         contactBitmask: TTCollisions.controlBlockContactBitmask,
                         zRotation: TTPhysics.blockZRotation,
                         impulse: TTPhysics.blockImpulse,
                         angularImpulse: TTPhysics.blockAngularImpulse)
    }

    func createScoreLine(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: TTPhysics.scoreLineMass,
                         velocity: .zero,
                         affectedByGravity: TTPhysics.scoreLineGravity,
                         linearDamping: TTPhysics.scoreLineLinearDamping,
                         isDynamic: TTPhysics.scoreLineIsDynamic,
                         allowsRotation: TTPhysics.scoreLineRotation,
                         restitution: TTPhysics.scoreLineCor,
                         friction: TTPhysics.scoreLineFriction,
                         ownBitmask: TTCollisions.scoreLineBitmask,
                         collideBitmask: TTCollisions.scoreLineCollideBitmask,
                         contactBitmask: TTCollisions.scoreLineContactBitmask,
                         zRotation: TTPhysics.scoreLineZRotation,
                         impulse: TTPhysics.scoreLineImpulse,
                         angularImpulse: TTPhysics.scoreLineAngularImpulse)
    }
}
