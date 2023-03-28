//
//  SPEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: SPPhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = SPPhysicsCreator()
    }

    @discardableResult
    func createSpaceship(index: Int, at position: CGPoint, of size: CGSize) -> Entity {
        let spaceship = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            AutoRotateComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "spaceship\(index)")
            SpaceshipComponent(index: index)
            physicsCreator.createSpaceship(of: size)
        }

        spaceship.assign(component: ScoreComponent(for: spaceship.id))

        return spaceship
    }

    @discardableResult
    func createRock(at position: CGPoint, angle: CGFloat, justActivatedBy playerId: EntityID) -> Entity {
        let size = SPSizes.rock
        let rock = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "rock")
            RockComponent(justActivatedBy: playerId)
            physicsCreator.createRock(of: size, pointing: angle)
        }
        return rock
    }

    @discardableResult
    func createBullet(index: Int, from playerId: EntityID, angle: CGFloat, position: CGPoint) -> Entity {
        let size = SPSizes.bullet
        // index is needed so I know what colour sprite to attach
        // playerId is needed so I know who fired it (if get hit by own bullet, is ok)
        let bullet = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent(angleInRadians: angle)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "bullet\(index)")
            BulletComponent(for: playerId)
            physicsCreator.createBullet(of: size, pointing: angle)
        }
        return bullet
    }

    @discardableResult
    func createPowerup() -> Entity {
        let size = SPSizes.powerup
        let position = CGPoint.random(within: Sizes.game)

        let powerup = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            physicsCreator.createPowerup(of: size)
        }

        let powerupComponents: [[Component]] = [
            [
                SpriteComponent(assetName: "gunPowerup"),
                PowerupComponent(ofType: GunPowerup())
            ],
            [
                SpriteComponent(assetName: "rockPowerup"),
                PowerupComponent(ofType: RockPowerup())
            ]
        ]

        for comp in powerupComponents.randomElement()! {
            powerup.assign(component: comp)
        }

        return powerup
    }
}
