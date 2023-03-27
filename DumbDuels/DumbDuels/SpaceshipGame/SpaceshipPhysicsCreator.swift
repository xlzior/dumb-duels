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
}
