//
//  SOPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

class SOPhysicsCreator {
    // TODO: refactor to physics details struct?
    func createPlayer(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: SOPhysics.playerMass,
                         velocity: .zero,
                         affectedByGravity: SOPhysics.playerGravity,
                         linearDamping: SOPhysics.playerStaticDamping,
                         isDynamic: SOPhysics.playerIsDynamic,
                         allowsRotation: SOPhysics.playerRotation,
                         restitution: SOPhysics.playerCor,
                         friction: SOPhysics.playerFriction,
                         ownBitmask: SOCollisions.playerBitmask,
                         collideBitmask: SOCollisions.playerCollideBitmask,
                         contactBitmask: SOCollisions.playerContactBitmask,
                         zRotation: SOPhysics.playerZRotation,
                         impulse: SOPhysics.playerImpulse,
                         angularImpulse: SOPhysics.playerAngularImpulse)
    }

    func createBall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(circleOf: size.height / 2,
                         mass: SOPhysics.ballMass,
                         velocity: .zero,
                         affectedByGravity: SOPhysics.ballGravity,
                         linearDamping: SOPhysics.ballStaticDamping,
                         isDynamic: SOPhysics.ballIsDynamic,
                         allowsRotation: SOPhysics.ballRotation,
                         restitution: SOPhysics.ballCor,
                         friction: SOPhysics.ballFriction,
                         ownBitmask: SOCollisions.ballBitmask,
                         collideBitmask: SOCollisions.ballCollideBitmask,
                         contactBitmask: SOCollisions.ballContactBitmask,
                         zRotation: SOPhysics.ballZRotation,
                         impulse: SOPhysics.ballImpulse,
                         angularImpulse: SOPhysics.ballAngularImpulse)
    }

    func createGoal(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: SOPhysics.goalMass,
                         velocity: .zero,
                         affectedByGravity: SOPhysics.goalGravity,
                         linearDamping: SOPhysics.goalStaticDamping,
                         isDynamic: SOPhysics.goalIsDynamic,
                         allowsRotation: SOPhysics.goalRotation,
                         restitution: SOPhysics.goalCor,
                         friction: SOPhysics.goalFriction,
                         ownBitmask: SOCollisions.goalBitmask,
                         collideBitmask: SOCollisions.goalCollideBitmask,
                         contactBitmask: SOCollisions.goalContactBitmask,
                         zRotation: SOPhysics.goalZRotation,
                         impulse: SOPhysics.goalImpulse,
                         angularImpulse: SOPhysics.goalAngularImpulse)
    }

    func createGoalSide(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: SOPhysics.goalMass,
                         velocity: .zero,
                         affectedByGravity: SOPhysics.goalGravity,
                         linearDamping: SOPhysics.goalStaticDamping,
                         isDynamic: SOPhysics.goalIsDynamic,
                         allowsRotation: SOPhysics.goalRotation,
                         restitution: SOPhysics.goalCor,
                         friction: SOPhysics.goalFriction,
                         ownBitmask: SOCollisions.goalSideBitmask,
                         collideBitmask: SOCollisions.goalSideCollideBitmask,
                         contactBitmask: SOCollisions.goalSideContactBitmask,
                         zRotation: SOPhysics.goalZRotation,
                         impulse: SOPhysics.goalImpulse,
                         angularImpulse: SOPhysics.goalAngularImpulse)
    }

    func createGoalBack(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: SOPhysics.goalMass,
                         velocity: .zero,
                         affectedByGravity: SOPhysics.goalGravity,
                         linearDamping: SOPhysics.goalStaticDamping,
                         isDynamic: SOPhysics.goalIsDynamic,
                         allowsRotation: SOPhysics.goalRotation,
                         restitution: SOPhysics.goalCor,
                         friction: SOPhysics.goalFriction,
                         ownBitmask: SOCollisions.goalBackBitmask,
                         collideBitmask: SOCollisions.goalBackCollideBitmask,
                         contactBitmask: SOCollisions.goalBackContactBitmask,
                         zRotation: SOPhysics.goalZRotation,
                         impulse: SOPhysics.goalImpulse,
                         angularImpulse: SOPhysics.goalAngularImpulse)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size,
                         mass: SOPhysics.wallMass,
                         velocity: .zero,
                         affectedByGravity: SOPhysics.wallGravity,
                         linearDamping: SOPhysics.wallStaticDamping,
                         isDynamic: SOPhysics.wallIsDynamic,
                         allowsRotation: SOPhysics.wallRotation,
                         restitution: SOPhysics.wallCor,
                         friction: SOPhysics.wallFriction,
                         ownBitmask: SOCollisions.wallBitmask,
                         collideBitmask: SOCollisions.wallCollideBitmask,
                         contactBitmask: SOCollisions.wallContactBitmask,
                         zRotation: SOPhysics.wallZRotation,
                         impulse: SOPhysics.wallImpulse,
                         angularImpulse: SOPhysics.wallAngularImpulse)
    }
}
