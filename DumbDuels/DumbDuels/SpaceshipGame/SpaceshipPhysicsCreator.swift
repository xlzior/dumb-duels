//
//  SpaceshipPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SpaceshipPhysicsCreator {
    func createSpaceship(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(
            circleOf: size.height / 2, mass: SpaceshipPhysics.spaceshipMass, velocity: .zero,
            affectedByGravity: SpaceshipPhysics.spaceshipGravity,
            linearDamping: SpaceshipPhysics.spaceshipDamping,
            isDynamic: SpaceshipPhysics.spaceshipIsDynamic,
            allowsRotation: SpaceshipPhysics.spaceshipRotation,
            restitution: SpaceshipPhysics.spaceshipCor,
            friction: SpaceshipPhysics.spaceshipFriction,
            ownBitmask: SpaceshipCollisions.spaceshipBitmask,
            collideBitmask: SpaceshipCollisions.spaceshipCollideBitmask,
            contactBitmask: SpaceshipCollisions.spaceshipContactBitmask,
            zRotation: SpaceshipPhysics.spaceshipZRotation,
            impulse: SpaceshipPhysics.spaceshipImpulse,
            angularImpulse: SpaceshipPhysics.spaceshipAngularImpulse)

        return component
    }

    func createRock(of size: CGSize, pointing: CGFloat) -> PhysicsComponent {
        let component = PhysicsComponent(
            circleOf: size.height / 2, mass: SpaceshipPhysics.rockMass, velocity: .zero,
            affectedByGravity: SpaceshipPhysics.rockGravity,
            linearDamping: SpaceshipPhysics.rockDamping,
            isDynamic: SpaceshipPhysics.rockIsDynamic,
            allowsRotation: SpaceshipPhysics.rockRotation,
            restitution: SpaceshipPhysics.rockCor,
            friction: SpaceshipPhysics.rockFriction,
            ownBitmask: SpaceshipCollisions.rockBitmask,
            collideBitmask: SpaceshipCollisions.rockCollideBitmask,
            contactBitmask: SpaceshipCollisions.rockContactBitmask,
            zRotation: SpaceshipPhysics.rockZRotation,
            impulse: SpaceshipConstants.propulsionForce * CGVector(angle: Double.pi / 2 - pointing),
            angularImpulse: SpaceshipPhysics.rockAngularImpulse)

        return component
    }

    func createBullet(of size: CGSize, pointing: CGFloat) -> PhysicsComponent {
        let component = PhysicsComponent(
            rectangleOf: size, mass: SpaceshipPhysics.bulletMass, velocity: .zero,
            affectedByGravity: SpaceshipPhysics.bulletGravity,
            linearDamping: SpaceshipPhysics.bulletDamping,
            isDynamic: SpaceshipPhysics.bulletIsDynamic,
            allowsRotation: SpaceshipPhysics.bulletRotation,
            restitution: SpaceshipPhysics.bulletCor,
            friction: SpaceshipPhysics.bulletFriction,
            ownBitmask: SpaceshipCollisions.bulletBitmask,
            collideBitmask: SpaceshipCollisions.bulletCollideBitmask,
            contactBitmask: SpaceshipCollisions.bulletContactBitmask,
            zRotation: SpaceshipPhysics.bulletZRotation,
            impulse: SpaceshipConstants.propulsionForce * CGVector(angle: Double.pi / 2 - pointing),
            angularImpulse: SpaceshipPhysics.bulletAngularImpulse)

        return component
    }

    func createPowerup(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(
            circleOf: size.height / 2, mass: SpaceshipPhysics.powerupMass, velocity: .zero,
            affectedByGravity: SpaceshipPhysics.powerupGravity,
            linearDamping: SpaceshipPhysics.powerupDamping,
            isDynamic: SpaceshipPhysics.powerupIsDynamic,
            allowsRotation: SpaceshipPhysics.powerupRotation,
            restitution: SpaceshipPhysics.powerupCor,
            friction: SpaceshipPhysics.powerupFriction,
            ownBitmask: SpaceshipCollisions.powerupBitmask,
            collideBitmask: SpaceshipCollisions.powerupCollideBitmask,
            contactBitmask: SpaceshipCollisions.powerupContactBitmask,
            zRotation: SpaceshipPhysics.powerupZRotation,
            impulse: SpaceshipPhysics.powerupImpulse,
            angularImpulse: SpaceshipPhysics.powerupAngularImpulse)

        return component
    }
}
