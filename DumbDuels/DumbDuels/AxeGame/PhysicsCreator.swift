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

    func createAxe(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(radius: size.height / 2, mass: Physics.axeMass, velocity: .zero,
                                         affectedByGravity: Physics.axeGravity,
                                         linearDamping: Physics.axeDamping,
                                         isDynamic: Physics.axeIsDynamic,
                                         allowsRotation: Physics.axeRotation,
                                         restitution: Physics.axeCor,
                                         friction: Physics.axeFriction,
                                         categoryBitMask: CollisionUtils.axeBitmask,
                                         collisionBitMask: CollisionUtils.axeCollideBitmask,
                                         contactTestBitMask: CollisionUtils.axeContactBitmask,
                                         zRotation: Physics.axeZRotation, impulse: Physics.axeInitialImpulse)
        return component
    }

    func createPlayer(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(size: size, mass: Physics.playerMass, velocity: .zero,
                                         affectedByGravity: Physics.playerGravity,
                                         linearDamping: Physics.playerDamping,
                                         isDynamic: Physics.playerIsDynamic,
                                         allowsRotation: Physics.playerRotation,
                                         restitution: Physics.playerCor,
                                         friction: Physics.playerFriction,
                                         categoryBitMask: CollisionUtils.playerBitmask,
                                         collisionBitMask: CollisionUtils.playerCollideBitmask,
                                         contactTestBitMask: CollisionUtils.playerContactBitmask,
                                         zRotation: Physics.playerZRotation, impulse: Physics.playerImpulse)
        return component
    }

    func createPlatform(of size: CGSize) -> PhysicsComponent {
        let component = PhysicsComponent(size: size, mass: Physics.platformMass, velocity: .zero,
                                         affectedByGravity: Physics.platformGravity,
                                         linearDamping: Physics.platformDamping,
                                         isDynamic: Physics.platformIsDynamic,
                                         allowsRotation: Physics.platformRotation,
                                         restitution: Physics.platformCor,
                                         friction: Physics.platformFriction,
                                         categoryBitMask: CollisionUtils.platformBitmask,
                                         collisionBitMask: CollisionUtils.platformCollideBitmask,
                                         contactTestBitMask: CollisionUtils.platformContactBitmask,
                                         zRotation: Physics.platformZRotation,
                                         impulse: Physics.playerImpulse)
        return component
    }

    func axeCollidable(axeId: EntityID) -> CollidableComponent {
        let axeCategory = AxeCategory(entityId: axeId)
        let component = CollidableComponent(categories: axeCategory)
        return component
    }

    func playerCollidable(playerId: EntityID) -> CollidableComponent {
        let playerCategory = PlayerCategory(entityId: playerId)
        let component = CollidableComponent(categories: playerCategory)
        return component
    }

    func platformCollidable(platformId: EntityID) -> CollidableComponent {
        let platformCategory = PlatformCategory(entityId: platformId)
        let component = CollidableComponent(categories: platformCategory)
        return component
    }
}
