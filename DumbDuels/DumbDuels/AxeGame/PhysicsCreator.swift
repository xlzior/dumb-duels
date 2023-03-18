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
        // TODO: radius is set to size.height for now
        print("axe size: \(size)")
        let component = PhysicsComponent(radius: size.height / 2, mass: Physics.axeMass, velocity: .zero,
                                         affectedByGravity: Physics.axeGravity,
                                         linearDamping: Physics.axeDamping,
                                         isDynamic: Physics.axeIsDynamic,
                                         allowsRotation: Physics.axeRotation,
                                         restitution: Physics.axeCor,
                                         friction: Physics.axeFriction,
                                         categoryBitMask: ColliisionUtils.axeBitmask,
                                         collisionBitMask: ColliisionUtils.axeCollideBitmask,
                                         contactTestBitMask: ColliisionUtils.axeContactBitmask,
                                         zRotation: Physics.axeZRotation, impulse: Physics.axeInitialImpulse)
        return component
    }

    func createPlayer(of size: CGSize) -> PhysicsComponent {
        print("player size: \(size)")
        let component = PhysicsComponent(size: size, mass: Physics.playerMass, velocity: .zero,
                                         affectedByGravity: Physics.playerGravity,
                                         linearDamping: Physics.playerDamping,
                                         isDynamic: Physics.playerIsDynamic,
                                         allowsRotation: Physics.playerRotation,
                                         restitution: Physics.playerCor,
                                         friction: Physics.playerFriction,
                                         categoryBitMask: ColliisionUtils.playerBitmask,
                                         collisionBitMask: ColliisionUtils.playerCollideBitmask,
                                         contactTestBitMask: ColliisionUtils.playerContactBitmask,
                                         zRotation: Physics.playerZRotation, impulse: Physics.playerImpulse)
        return component
    }

    func createPlatform(of size: CGSize) -> PhysicsComponent {
        print("platform size: \(size)")
        let component = PhysicsComponent(size: size, mass: Physics.platformMass, velocity: .zero,
                                         affectedByGravity: Physics.platformGravity,
                                         linearDamping: Physics.platformDamping,
                                         isDynamic: Physics.platformIsDynamic,
                                         allowsRotation: Physics.platformRotation,
                                         restitution: Physics.platformCor,
                                         friction: Physics.platformFriction,
                                         categoryBitMask: ColliisionUtils.platformBitmask,
                                         collisionBitMask: ColliisionUtils.platformCollideBitmask,
                                         contactTestBitMask: ColliisionUtils.platformContactBitmask,
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
