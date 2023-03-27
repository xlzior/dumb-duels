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
            SpaceshipComponent()
        }
        let physicsComponent = physicsCreator.createSpaceship(of: size, for: spaceship.id)
        spaceship.assign(component: physicsComponent)

        return spaceship
    }
}
