//
//  SPPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPPhysicsCreator {
    func createSpaceship(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(
            circleOf: size.height / 2, mass: SPPhysics.spaceshipMass, velocity: .zero,
            affectedByGravity: SPPhysics.spaceshipGravity,
            linearDamping: SPPhysics.spaceshipDamping,
            isDynamic: SPPhysics.spaceshipIsDynamic,
            allowsRotation: SPPhysics.spaceshipRotation,
            restitution: SPPhysics.spaceshipCor,
            friction: SPPhysics.spaceshipFriction,
            ownBitmask: SPCollisions.spaceshipBitmask,
            collideBitmask: SPCollisions.spaceshipCollideBitmask,
            contactBitmask: SPCollisions.spaceshipContactBitmask,
            zRotation: SPPhysics.spaceshipZRotation,
            impulse: SPPhysics.spaceshipImpulse,
            angularImpulse: SPPhysics.spaceshipAngularImpulse)

        return component
    }

    func createRock(of size: CGSize, pointing: CGFloat) -> PhysicsComponent {
        let component = PhysicsComponent(
            circleOf: size.height / 2, mass: SPPhysics.rockMass, velocity: .zero,
            affectedByGravity: SPPhysics.rockGravity,
            linearDamping: SPPhysics.rockDamping,
            isDynamic: SPPhysics.rockIsDynamic,
            allowsRotation: SPPhysics.rockRotation,
            restitution: SPPhysics.rockCor,
            friction: SPPhysics.rockFriction,
            ownBitmask: SPCollisions.rockBitmask,
            collideBitmask: SPCollisions.rockCollideBitmask,
            contactBitmask: SPCollisions.rockContactBitmask,
            zRotation: SPPhysics.rockZRotation,
            impulse: SPConstants.rockForce * CGVector(angle: Double.pi / 2 - pointing),
            angularImpulse: SPPhysics.rockAngularImpulse)

        return component
    }

    func createBullet(of size: CGSize, pointing: CGFloat) -> PhysicsComponent {
        let component = PhysicsComponent(
            rectangleOf: size, mass: SPPhysics.bulletMass, velocity: .zero,
            affectedByGravity: SPPhysics.bulletGravity,
            linearDamping: SPPhysics.bulletDamping,
            isDynamic: SPPhysics.bulletIsDynamic,
            allowsRotation: SPPhysics.bulletRotation,
            restitution: SPPhysics.bulletCor,
            friction: SPPhysics.bulletFriction,
            ownBitmask: SPCollisions.bulletBitmask,
            collideBitmask: SPCollisions.bulletCollideBitmask,
            contactBitmask: SPCollisions.bulletContactBitmask,
            zRotation: SPPhysics.bulletZRotation,
            impulse: SPConstants.bulletForce * CGVector(angle: Double.pi / 2 - pointing),
            angularImpulse: SPPhysics.bulletAngularImpulse)

        return component
    }

    func createPowerup(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(
            circleOf: size.height / 2, mass: SPPhysics.powerupMass, velocity: .zero,
            affectedByGravity: SPPhysics.powerupGravity,
            linearDamping: SPPhysics.powerupDamping,
            isDynamic: SPPhysics.powerupIsDynamic,
            allowsRotation: SPPhysics.powerupRotation,
            restitution: SPPhysics.powerupCor,
            friction: SPPhysics.powerupFriction,
            ownBitmask: SPCollisions.powerupBitmask,
            collideBitmask: SPCollisions.powerupCollideBitmask,
            contactBitmask: SPCollisions.powerupContactBitmask,
            zRotation: SPPhysics.powerupZRotation,
            impulse: SPPhysics.powerupImpulse,
            angularImpulse: SPPhysics.powerupAngularImpulse)

        return component
    }
}
