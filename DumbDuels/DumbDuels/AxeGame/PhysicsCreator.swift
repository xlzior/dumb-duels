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
        let component = PhysicsComponent(radius: size.height / 2, mass: Physics.axeMass, velocity: .zero,
                                         affectedByGravity: Physics.axeGravity,
                                         linearDamping: Physics.axeDamping,
                                         isDynamic: Physics.axeIsDynamic,
                                         allowsRotation: Physics.axeRotation,
                                         restitution: Physics.axeCor,
                                         friction: Physics.axeFriction,
                                         categories: [axeCategory],
                                         zRotation: Physics.axeZRotation, impulse: Physics.axeInitialImpulse)
        return component
    }

    func createPlayer(of size: CGSize, for playerId: EntityID) -> PhysicsComponent {
        let playerCategory = PlayerCategory(entityId: playerId)
        let component = PhysicsComponent(size: size, mass: Physics.playerMass, velocity: .zero,
                                         affectedByGravity: Physics.playerGravity,
                                         linearDamping: Physics.playerDamping,
                                         isDynamic: Physics.playerIsDynamic,
                                         allowsRotation: Physics.playerRotation,
                                         restitution: Physics.playerCor,
                                         friction: Physics.playerFriction,
                                         categories: [playerCategory],
                                         zRotation: Physics.playerZRotation, impulse: Physics.playerImpulse)
        return component
    }

    func createPlatform(of size: CGSize, for platformId: EntityID) -> PhysicsComponent {
        let platformCategory = PlatformCategory(entityId: platformId)
        let component = PhysicsComponent(size: size, mass: Physics.platformMass, velocity: .zero,
                                         affectedByGravity: Physics.platformGravity,
                                         linearDamping: Physics.platformDamping,
                                         isDynamic: Physics.platformIsDynamic,
                                         allowsRotation: Physics.platformRotation,
                                         restitution: Physics.platformCor,
                                         friction: Physics.platformFriction,
                                         categories: [platformCategory],
                                         zRotation: Physics.platformZRotation,
                                         impulse: Physics.playerImpulse)
        return component
    }
}
