//
//  EntityCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics
import DuelKit
import Foundation

class EntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: PhysicsCreator
    private let animationCreator: AnimationCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = PhysicsCreator()
        self.animationCreator = AnimationCreator()
    }

    func createAxe(at position: CGPoint, of size: CGSize) -> Entity {
        let axe = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.axe)
            AxeComponent()
        }
//        let collidable = physicsCreator.axeCollidable(axeId: axe.id)
//        let physicsComponent = physicsCreator.createAxe(of: size)
//        axe.assign(component: collidable)
//        axe.assign(component: physicsComponent)
        return axe
    }

    func createAxe(
        withHorizontalOffset offset: CGFloat,
        from position: CGPoint,
        of size: CGSize,
        facing: FaceDirection,
        onPlatform platformId: EntityID) -> Entity {
        let axePosition = CGPoint(x: position.x + offset, y: position.y)
        let axe = entityManager.createEntity {
            PositionComponent(position: axePosition, faceDirection: facing)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.axe)
            SyncXPositionComponent(syncFrom: platformId, offset: offset)
            AxeComponent()
        }
//        let collidable = physicsCreator.axeCollidable(axeId: axe.id)
//        let physicsComponent = physicsCreator.createAxe(of: size)
//        axe.assign(component: collidable)
//        axe.assign(component: physicsComponent)
        return axe
    }

    func createThrowStrength(at position: CGPoint) -> Entity {
        let throwStrength = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: CGSize(width: 75, height: 30))
        }

        let fsm = EntityStateMachine<ThrowStrengthComponent.State>(entity: throwStrength)
        fsm.createState(name: .charging)
            .addInstance(SpriteComponent(assetName: Assets.chargingBar))
        fsm.createState(name: .notCharging)

        throwStrength.assign(component: ThrowStrengthComponent(fsm: fsm))
        fsm.changeState(name: .notCharging)

        return throwStrength
    }

    func createPlayer(
        index: Int,
        at position: CGPoint,
        facing faceDirection: FaceDirection,
        of size: CGSize,
        holding axeEntityID: EntityID,
        onPlatform platformId: EntityID
    ) -> Entity {
        let throwStrengthEntity = createThrowStrength(at: position + CGPoint(x: 0, y: 100))

        let player = entityManager.createEntity {
            PositionComponent(position: position, faceDirection: faceDirection)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.player)
            CanJumpComponent()
            SyncXPositionComponent(syncFrom: platformId, offset: 0)
            WithThrowStrengthComponent(throwStrengthEntityId: throwStrengthEntity.id)
        }
        let scoreComponent = ScoreComponent(for: player.id)
        player.assign(component: scoreComponent)
        let physicsComponent = physicsCreator.createPlayer(of: size)
        player.assign(component: physicsComponent)
        let animationComponent = animationCreator.createPlayerHitAnimation()
        player.assign(component: animationComponent)

        entityManager.assign(component: PlayerComponent(idx: index), to: player)
        player.assign(component: HoldingAxeComponent(axeEntityID: axeEntityID))

        return player
    }

    func createPlatform(at position: CGPoint, of size: CGSize) -> Entity {
        let platform = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.platform)
            PlatformComponent()
        }
        let physicsComponent = physicsCreator.createPlatform(of: size)
        platform.assign(component: physicsComponent)

        return platform
    }

    func createPlatform(withVerticalOffset offset: CGFloat, from position: CGPoint, of size: CGSize) -> Entity {
        let platformPosition = CGPoint(x: position.x, y: position.y + offset)
        let platform = entityManager.createEntity {
            PositionComponent(position: platformPosition)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.platform)
            PlatformComponent()
            OscillationComponent(centerOfOscillation: platformPosition,
                                 axis: Oscillation.horizontalAxis, amplitude: Oscillation.platformAmplitude,
                                 period: Oscillation.platformPeriod, displacement: Oscillation.platformDisplacement)
        }
        let physicsComponent = physicsCreator.createPlatform(of: size)
        platform.assign(component: physicsComponent)

        return platform
    }

    func createWall(at position: CGPoint, of size: CGSize) -> Entity {
        let wall = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            WallComponent()
        }

        let physicsComponent = physicsCreator.createWall(of: size)
        wall.assign(component: physicsComponent)

        return wall
    }

    func createPeg(at position: CGPoint, of size: CGSize) -> Entity {
        let peg = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.peg)
            PegComponent()
            OscillationComponent(centerOfOscillation: position,
                                 axis: Oscillation.verticalAxis, amplitude: Oscillation.pegAmplitude,
                                 period: Oscillation.pegPeriod, displacement: Double.random(in: 1...10))
        }

        let physicsComponent = physicsCreator.createPeg(of: size)
        peg.assign(component: physicsComponent)

        return peg
    }

    @discardableResult
    func createAxeParticle(at position: CGPoint, of size: CGSize, sprite: String, impulse: CGVector) -> Entity {
        let axeParticle = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: sprite)
        }
        let physicsComponent = physicsCreator.createParticle(of: size.width / 2, with: impulse)
        axeParticle.assign(component: physicsComponent)
        let animationComponent = animationCreator.createAxeParticleAnimation()
        axeParticle.assign(component: animationComponent)

        return axeParticle
    }

    func createLava(at position: CGPoint, of size: CGSize) -> Entity {
        let lava = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.lava)
        }

        let physicsComponent = physicsCreator.createLava(of: size, for: lava.id)
        lava.assign(component: physicsComponent)

        return lava
    }

    func createLavaSmoke(at position: CGPoint, of size: CGSize) -> Entity {
        let lavaSmoke = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.lava)
        }

        let animationComponent = animationCreator.createLavaSmokeAnimation()
        lavaSmoke.assign(component: animationComponent)

        return lavaSmoke
    }

    @discardableResult
    func createBattleText(at position: CGPoint, of size: CGSize) -> Entity {
        let battleText = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: Assets.battleText)
        }
        let animationComponent = animationCreator.createBattleFlashAnimation()
        battleText.assign(component: animationComponent)

        return battleText
    }

    @discardableResult
    func createGameOverText(at position: CGPoint, of size: CGSize, displaying text: String) -> Entity {
        let gameOverText = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: text)
        }

        return gameOverText
    }
}
