//
//  PhysicsCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation
import DuelKit

class PhysicsCreator {
    func createAxe(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(circleOf: size.height / 2, mass: Physics.axeMass, velocity: .zero,
                                         affectedByGravity: Physics.axeGravity,
                                         linearDamping: Physics.axeDamping,
                                         isDynamic: Physics.axeIsDynamic,
                                         allowsRotation: Physics.axeRotation,
                                         restitution: Physics.axeCor,
                                         friction: Physics.axeFriction,
                                         ownBitmask: Collisions.axeBitmask,
                                         collideBitmask: Collisions.axeCollideBitmask,
                                         contactBitmask: Collisions.axeContactBitmask,
                                         zRotation: Physics.axeZRotation,
                                         impulse: Physics.axeInitialImpulse,
                                         angularImpulse: Physics.axeInitialAngularImpulse)
        return component
    }

    func createPlayer(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.playerMass, velocity: .zero,
                                         affectedByGravity: Physics.playerGravity,
                                         linearDamping: Physics.playerDamping,
                                         isDynamic: Physics.playerIsDynamic,
                                         allowsRotation: Physics.playerRotation,
                                         restitution: Physics.playerCor,
                                         friction: Physics.playerFriction,
                                         ownBitmask: Collisions.playerBitmask,
                                         collideBitmask: Collisions.playerCollideBitmask,
                                         contactBitmask: Collisions.playerContactBitmask,
                                         zRotation: Physics.playerZRotation,
                                         impulse: Physics.playerImpulse,
                                         angularImpulse: Physics.playerAngularImpulse)
        return component
    }

    func createPlatform(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.platformMass, velocity: .zero,
                                         affectedByGravity: Physics.platformGravity,
                                         linearDamping: Physics.platformDamping,
                                         isDynamic: Physics.platformIsDynamic,
                                         allowsRotation: Physics.platformRotation,
                                         restitution: Physics.platformCor,
                                         friction: Physics.platformFriction,
                                         ownBitmask: Collisions.platformBitmask,
                                         collideBitmask: Collisions.platformCollideBitmask,
                                         contactBitmask: Collisions.platformContactBitmask,
                                         zRotation: Physics.platformZRotation,
                                         impulse: Physics.platformImpulse,
                                         angularImpulse: Physics.platformAngularImpulse)
        return component
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.wallMass, velocity: .zero,
                                         affectedByGravity: Physics.wallGravity,
                                         linearDamping: Physics.wallDamping,
                                         isDynamic: Physics.wallIsDynamic,
                                         allowsRotation: Physics.wallRotation,
                                         restitution: Physics.wallCor,
                                         friction: Physics.wallFriction,
                                         ownBitmask: Collisions.wallBitmask,
                                         collideBitmask: Collisions.wallCollideBitmask,
                                         contactBitmask: Collisions.wallContactBitmask,
                                         zRotation: Physics.wallZRotation,
                                         impulse: Physics.wallImpulse,
                                         angularImpulse: Physics.wallAngularImpulse)
        return component
    }

    func createPeg(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.pegMass, velocity: .zero,
                                         affectedByGravity: Physics.pegGravity,
                                         linearDamping: Physics.pegDamping,
                                         isDynamic: Physics.pegIsDynamic,
                                         allowsRotation: Physics.pegRotation,
                                         restitution: Physics.pegCor,
                                         friction: Physics.pegFriction,
                                         ownBitmask: Collisions.pegBitmask,
                                         collideBitmask: Collisions.pegCollideBitmask,
                                         contactBitmask: Collisions.pegContactBitmask,
                                         zRotation: Physics.pegZRotation,
                                         impulse: Physics.pegImpulse,
                                         angularImpulse: Physics.pegAngularImpulse)
        return component
    }

    func createParticle(of radius: CGFloat, with initialImpulse: CGVector) -> PhysicsComponent {
        let component = PhysicsComponent(circleOf: radius, mass: Physics.axeParticleMass,
                                         velocity: .zero,
                                         affectedByGravity: Physics.axeParticleGravity,
                                         linearDamping: Physics.axeParticleDamping,
                                         isDynamic: Physics.axeParticleIsDynamic,
                                         allowsRotation: Physics.axeParticleRotation,
                                         restitution: Physics.axeParticleCor,
                                         friction: Physics.axeParticleFriction,
                                         ownBitmask: Collisions.axeParticleBitmask,
                                         collideBitmask: Collisions.axeParticleCollideBitmask,
                                         contactBitmask: Collisions.axeParticleContactBitmask,
                                         zRotation: Physics.axeParticleZRotation,
                                         impulse: initialImpulse,
                                         angularImpulse: Physics.axeParticleInitialAngularImpulse)
        return component
    }

    func createLava(of size: CGSize, for lavaId: EntityID) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.lavaMass, velocity: .zero,
                                         affectedByGravity: Physics.lavaGravity,
                                         linearDamping: Physics.lavaDamping,
                                         isDynamic: Physics.lavaIsDynamic,
                                         allowsRotation: Physics.lavaRotation,
                                         restitution: Physics.lavaCor,
                                         friction: Physics.lavaFriction,
                                         ownBitmask: Collisions.lavaBitmask,
                                         collideBitmask: Collisions.lavaCollideBitmask,
                                         contactBitmask: Collisions.lavaContactBitmask,
                                         zRotation: Physics.lavaZRotation,
                                         impulse: Physics.lavaImpulse,
                                         angularImpulse: Physics.lavaAngularImpulse)
        return component
    }
}
