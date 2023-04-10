//
//  SPEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit
import Foundation

class SPEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: SPPhysicsCreator
    private let animationCreator: SPAnimationCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = SPPhysicsCreator()
        self.animationCreator = SPAnimationCreator()
    }

    @discardableResult
    func createSpaceship(index: Int, at position: CGPoint, of size: CGSize,
                         score: Int = 0) -> Entity {
        let spaceship = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            AutoRotateComponent(by: SPConstants.rotationSpeed)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "spaceship\(index)")
            SpaceshipComponent(index: index)
            WillExplodeParticlesComponent(particles: Assets.particles[index])
            SoundComponent(sounds: [SPSoundTypes.spaceshipEngine: EngineSound()])
            physicsCreator.createSpaceship(of: size)
        }

        spaceship.assign(component: ScoreComponent(for: index, withId: spaceship.id, score: score))

        return spaceship
    }

    @discardableResult
    func createRock(at position: CGPoint,
                    velocity: CGVector,
                    of size: CGSize = SPSizes.rock) -> Entity {
        let rock = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "rock")
            RockComponent()
            physicsCreator.createRock(of: size, velocity: velocity)
        }
        return rock
    }

    @discardableResult
    func createBullet(index: Int,
                      from playerId: EntityID,
                      angle: CGFloat,
                      position: CGPoint,
                      size: CGSize = SPSizes.bullet
    ) -> Entity {
        // index is needed so I know what colour sprite to attach
        // playerId is needed so I know who fired it (if get hit by own bullet, is ok)
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent(angleInRadians: angle)
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "bullet\(index)")
            BulletComponent(for: playerId)
            SoundComponent(sounds: [SPSoundTypes.bullet: BulletSound(isPlaying: true)])
            physicsCreator.createBullet(of: size, pointing: angle)
        }
    }

    @discardableResult
    func createPowerup(at position: CGPoint, of size: CGSize) -> Entity {
        let powerup = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SoundComponent(sounds: [SPSoundTypes.powerup: PowerupSound()])
            physicsCreator.createPowerup(of: size)
        }

        let powerupComponents: [[Component]] = [
            [
                SpriteComponent(assetName: "gunPowerup"),
                PowerupComponent(ofType: GunPowerup())
            ],
            [
                SpriteComponent(assetName: "bombPowerup"),
                PowerupComponent(ofType: BombPowerup())
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

    @discardableResult
    func createAccelerationParticle(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.lava)
            animationCreator.createAccelerationParticle()
        }
    }

    @discardableResult
    func createSpaceshipParticle(at position: CGPoint, of size: CGSize, sprite: String,
                                 deltaPosition: CGPoint, travelTime: CGFloat) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: sprite)
            animationCreator.createSpaceshipParticleAnimation(
                deltaPosition: deltaPosition, travelTime: travelTime)
        }
    }

    @discardableResult
    func createStarParticle(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            StarComponent()
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: SPAssets.star)
            animationCreator.createStarAnimation(initialPosition: position)
        }
    }
}
