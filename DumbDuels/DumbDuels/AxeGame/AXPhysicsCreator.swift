//
//  AXPhysicsCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation
import DuelKit

class AXPhysicsCreator {
    func createAxe(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(circleOf: size.height / 2, mass: AXPhysics.axeMass, velocity: .zero,
                                         affectedByGravity: AXPhysics.axeGravity,
                                         linearDamping: AXPhysics.axeDamping,
                                         isDynamic: AXPhysics.axeIsDynamic,
                                         allowsRotation: AXPhysics.axeRotation,
                                         restitution: AXPhysics.axeCor,
                                         friction: AXPhysics.axeFriction,
                                         ownBitmask: AXCollisions.axeBitmask,
                                         collideBitmask: AXCollisions.axeCollideBitmask,
                                         contactBitmask: AXCollisions.axeContactBitmask,
                                         zRotation: AXPhysics.axeZRotation,
                                         impulse: AXPhysics.axeInitialImpulse,
                                         angularImpulse: AXPhysics.axeInitialAngularImpulse)
        return component
    }

    func createPlayer(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: AXPhysics.playerMass, velocity: .zero,
                                         affectedByGravity: AXPhysics.playerGravity,
                                         linearDamping: AXPhysics.playerDamping,
                                         isDynamic: AXPhysics.playerIsDynamic,
                                         allowsRotation: AXPhysics.playerRotation,
                                         restitution: AXPhysics.playerCor,
                                         friction: AXPhysics.playerFriction,
                                         ownBitmask: AXCollisions.playerBitmask,
                                         collideBitmask: AXCollisions.playerCollideBitmask,
                                         contactBitmask: AXCollisions.playerContactBitmask,
                                         zRotation: AXPhysics.playerZRotation,
                                         impulse: AXPhysics.playerImpulse,
                                         angularImpulse: AXPhysics.playerAngularImpulse)
        return component
    }

    func createPlatform(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: AXPhysics.platformMass, velocity: .zero,
                                         affectedByGravity: AXPhysics.platformGravity,
                                         linearDamping: AXPhysics.platformDamping,
                                         isDynamic: AXPhysics.platformIsDynamic,
                                         allowsRotation: AXPhysics.platformRotation,
                                         restitution: AXPhysics.platformCor,
                                         friction: AXPhysics.platformFriction,
                                         ownBitmask: AXCollisions.platformBitmask,
                                         collideBitmask: AXCollisions.platformCollideBitmask,
                                         contactBitmask: AXCollisions.platformContactBitmask,
                                         zRotation: AXPhysics.platformZRotation,
                                         impulse: AXPhysics.platformImpulse,
                                         angularImpulse: AXPhysics.platformAngularImpulse)
        return component
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: AXPhysics.wallMass, velocity: .zero,
                                         affectedByGravity: AXPhysics.wallGravity,
                                         linearDamping: AXPhysics.wallDamping,
                                         isDynamic: AXPhysics.wallIsDynamic,
                                         allowsRotation: AXPhysics.wallRotation,
                                         restitution: AXPhysics.wallCor,
                                         friction: AXPhysics.wallFriction,
                                         ownBitmask: AXCollisions.wallBitmask,
                                         collideBitmask: AXCollisions.wallCollideBitmask,
                                         contactBitmask: AXCollisions.wallContactBitmask,
                                         zRotation: AXPhysics.wallZRotation,
                                         impulse: AXPhysics.wallImpulse,
                                         angularImpulse: AXPhysics.wallAngularImpulse)
        return component
    }

    func createPeg(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: AXPhysics.pegMass, velocity: .zero,
                                         affectedByGravity: AXPhysics.pegGravity,
                                         linearDamping: AXPhysics.pegDamping,
                                         isDynamic: AXPhysics.pegIsDynamic,
                                         allowsRotation: AXPhysics.pegRotation,
                                         restitution: AXPhysics.pegCor,
                                         friction: AXPhysics.pegFriction,
                                         ownBitmask: AXCollisions.pegBitmask,
                                         collideBitmask: AXCollisions.pegCollideBitmask,
                                         contactBitmask: AXCollisions.pegContactBitmask,
                                         zRotation: AXPhysics.pegZRotation,
                                         impulse: AXPhysics.pegImpulse,
                                         angularImpulse: AXPhysics.pegAngularImpulse)
        return component
    }

    func createParticle(of radius: CGFloat, with initialImpulse: CGVector) -> PhysicsComponent {
        let component = PhysicsComponent(circleOf: radius, mass: AXPhysics.axeParticleMass,
                                         velocity: .zero,
                                         affectedByGravity: AXPhysics.axeParticleGravity,
                                         linearDamping: AXPhysics.axeParticleDamping,
                                         isDynamic: AXPhysics.axeParticleIsDynamic,
                                         allowsRotation: AXPhysics.axeParticleRotation,
                                         restitution: AXPhysics.axeParticleCor,
                                         friction: AXPhysics.axeParticleFriction,
                                         ownBitmask: AXCollisions.axeParticleBitmask,
                                         collideBitmask: AXCollisions.axeParticleCollideBitmask,
                                         contactBitmask: AXCollisions.axeParticleContactBitmask,
                                         zRotation: AXPhysics.axeParticleZRotation,
                                         impulse: initialImpulse,
                                         angularImpulse: AXPhysics.axeParticleInitialAngularImpulse)
        return component
    }

    func createLava(of size: CGSize, for lavaId: EntityID) -> PhysicsComponent {
        let component = PhysicsComponent(rectangleOf: size, mass: AXPhysics.lavaMass, velocity: .zero,
                                         affectedByGravity: AXPhysics.lavaGravity,
                                         linearDamping: AXPhysics.lavaDamping,
                                         isDynamic: AXPhysics.lavaIsDynamic,
                                         allowsRotation: AXPhysics.lavaRotation,
                                         restitution: AXPhysics.lavaCor,
                                         friction: AXPhysics.lavaFriction,
                                         ownBitmask: AXCollisions.lavaBitmask,
                                         collideBitmask: AXCollisions.lavaCollideBitmask,
                                         contactBitmask: AXCollisions.lavaContactBitmask,
                                         zRotation: AXPhysics.lavaZRotation,
                                         impulse: AXPhysics.lavaImpulse,
                                         angularImpulse: AXPhysics.lavaAngularImpulse)
        return component
    }
}
