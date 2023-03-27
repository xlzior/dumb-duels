//
//  SpaceshipEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SpaceshipEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: SpaceshipPhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = SpaceshipPhysicsCreator()
    }

    func createSpaceship(index: Int, at position: CGPoint, of size: CGSize) -> Entity {
        let spaceship = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "spaceship\(index)")
            SpaceshipComponent(index: index)
            physicsCreator.createSpaceship(of: size)
        }

        return spaceship
    }

    func createRock(at position: CGPoint, of size: CGSize, direction: CGFloat) -> Entity {
        let rock = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "rock")
            RockComponent()
            physicsCreator.createRock(of: size, pointing: direction)
        }
        return rock
    }

    func createBullet(index: Int, from playerId: EntityID, direction: CGFloat, at position: CGPoint, of size: CGSize) -> Entity {
        let bullet = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent(angleInRadians: direction)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "bullet\(index)")
            BulletComponent(for: playerId)
            physicsCreator.createBullet(of: size, pointing: direction)
        }
        return bullet
    }
}
