//
//  PhysicsCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class PhysicsCreator {
    private let entityManager: EntityManager

    init(entityManager: EntityManager) {
        self.entityManager = EntityManager()
    }

    func createAxe(of size: CGSize, for axeId: EntityID) -> PhysicsComponent {
        let axeCategory = AxeCategory(entityId: axeId)
        let component = PhysicsComponent(circleOf: size.height / 2, mass: Physics.axeMass, velocity: .zero,
                                         affectedByGravity: Physics.axeGravity,
                                         linearDamping: Physics.axeDamping,
                                         isDynamic: Physics.axeIsDynamic,
                                         allowsRotation: Physics.axeRotation,
                                         restitution: Physics.axeCor,
                                         friction: Physics.axeFriction,
                                         categories: [axeCategory],
                                         zRotation: Physics.axeZRotation,
                                         impulse: Physics.axeInitialImpulse,
                                         angularImpulse: Physics.axeInitialAngularImpulse)
        return component
    }

    func createPlayer(of size: CGSize, for playerId: EntityID) -> PhysicsComponent {
        let playerCategory = PlayerCategory(entityId: playerId)
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.playerMass, velocity: .zero,
                                         affectedByGravity: Physics.playerGravity,
                                         linearDamping: Physics.playerDamping,
                                         isDynamic: Physics.playerIsDynamic,
                                         allowsRotation: Physics.playerRotation,
                                         restitution: Physics.playerCor,
                                         friction: Physics.playerFriction,
                                         categories: [playerCategory],
                                         zRotation: Physics.playerZRotation,
                                         impulse: Physics.playerImpulse,
                                         angularImpulse: Physics.playerAngularImpulse)
        return component
    }

    func createPlatform(of size: CGSize, for platformId: EntityID) -> PhysicsComponent {
        let platformCategory = PlatformCategory(entityId: platformId)
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.platformMass, velocity: .zero,
                                         affectedByGravity: Physics.platformGravity,
                                         linearDamping: Physics.platformDamping,
                                         isDynamic: Physics.platformIsDynamic,
                                         allowsRotation: Physics.platformRotation,
                                         restitution: Physics.platformCor,
                                         friction: Physics.platformFriction,
                                         categories: [platformCategory],
                                         zRotation: Physics.platformZRotation,
                                         impulse: Physics.platformImpulse,
                                         angularImpulse: Physics.platformAngularImpulse)
        return component
    }

    func createWall(of size: CGSize, for wallId: EntityID) -> PhysicsComponent {
        let wallCategory = WallCategory(entityId: wallId)
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.wallMass, velocity: .zero,
                                         affectedByGravity: Physics.wallGravity,
                                         linearDamping: Physics.wallDamping,
                                         isDynamic: Physics.wallIsDynamic,
                                         allowsRotation: Physics.wallRotation,
                                         restitution: Physics.wallCor,
                                         friction: Physics.wallFriction,
                                         categories: [wallCategory],
                                         zRotation: Physics.wallZRotation,
                                         impulse: Physics.wallImpulse,
                                         angularImpulse: Physics.wallAngularImpulse)
        return component
    }

    func createPeg(of size: CGSize, for pegId: EntityID) -> PhysicsComponent {
        let pegCategory = PegCategory(entityId: pegId)
        let component = PhysicsComponent(rectangleOf: size, mass: Physics.pegMass, velocity: .zero,
                                         affectedByGravity: Physics.pegGravity,
                                         linearDamping: Physics.pegDamping,
                                         isDynamic: Physics.pegIsDynamic,
                                         allowsRotation: Physics.pegRotation,
                                         restitution: Physics.pegCor,
                                         friction: Physics.pegFriction,
                                         categories: [pegCategory],
                                         zRotation: Physics.pegZRotation,
                                         impulse: Physics.pegImpulse,
                                         angularImpulse: Physics.pegAngularImpulse)
        return component
    }
}
