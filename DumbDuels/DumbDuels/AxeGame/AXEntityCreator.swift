//
//  AXEntityCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics
import DuelKit
import Foundation

class AXEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: AXPhysicsCreator
    private let animationCreator: AXAnimationCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = AXPhysicsCreator()
        self.animationCreator = AXAnimationCreator()
    }

    @discardableResult
    func createAxe(at position: CGPoint, of size: CGSize) -> Entity {
        let axe = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.axe)
            AxeComponent()
        }
        return axe
    }

    @discardableResult
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
            SpriteComponent(assetName: AXAssets.axe)
            SyncXPositionComponent(syncFrom: platformId, offset: offset)
            AxeComponent()
        }

        let soundComponent = SoundComponent(sounds: [
            AXSoundTypes.axeExplode: ExplodeSound()
        ])
        axe.assign(component: soundComponent)

        return axe
    }

    @discardableResult
    func createThrowStrength(at position: CGPoint) -> Entity {
        let throwStrength = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: CGSize(width: 75, height: 30))
        }

        let fsm = EntityStateMachine<ThrowStrengthComponent.State>(entity: throwStrength)
        fsm.createState(name: .charging)
            .addInstance(SpriteComponent(assetName: AXAssets.chargingBar))
        fsm.createState(name: .notCharging)

        throwStrength.assign(component: ThrowStrengthComponent(fsm: fsm))
        fsm.changeState(name: .notCharging)

        return throwStrength
    }

    @discardableResult
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
            PlayerComponent(index: index)
            PositionComponent(position: position, faceDirection: faceDirection)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.player[index])
            CanJumpComponent()
            SyncXPositionComponent(syncFrom: platformId, offset: 0)
            WithThrowStrengthComponent(throwStrengthEntityId: throwStrengthEntity.id)
            HoldingAxeComponent(axeEntityID: axeEntityID)
            physicsCreator.createPlayer(of: size)
            animationCreator.createPlayerHitAnimation(index: index)
        }
        // Sync throwStrength entity position using player position
        let syncXComponent = SyncXPositionComponent(syncFrom: player.id)
        throwStrengthEntity.assign(component: syncXComponent)

        let scoreComponent = ScoreComponent(for: index, withId: player.id)
        player.assign(component: scoreComponent)

        let soundComponent = SoundComponent(sounds: [
            AXSoundTypes.playerJump: PlayerJumpSound(),
            AXSoundTypes.playerHit: PlayerHitSound()
        ])
        player.assign(component: soundComponent)

        return player
    }

    @discardableResult
    func createPlatform(at position: CGPoint, of size: CGSize) -> Entity {
        let platform = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.platform)
            PlatformComponent()
        }
        let physicsComponent = physicsCreator.createPlatform(of: size)
        platform.assign(component: physicsComponent)

        return platform
    }

    @discardableResult
    func createPlatform(
        withVerticalOffset offset: CGFloat,
        from position: CGPoint,
        of size: CGSize,
        index: Int
    ) -> Entity {
        let platformPosition = CGPoint(x: position.x, y: position.y + offset)
        let platform = entityManager.createEntity {
            PositionComponent(position: platformPosition)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.platform)
            PlatformComponent()
            OscillationComponent(centerOfOscillation: platformPosition,
                                 axis: AXOscillation.horizontalAxis,
                                 amplitude: AXOscillation.platformAmplitude[index],
                                 period: AXOscillation.platformPeriod[index],
                                 displacement: AXOscillation.platformDisplacement[index])
        }
        let physicsComponent = physicsCreator.createPlatform(of: size)
        platform.assign(component: physicsComponent)

        return platform
    }

    @discardableResult
    func createWall(at position: CGPoint, of size: CGSize) -> Entity {
        let wall = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
        }

        let physicsComponent = physicsCreator.createWall(of: size)
        wall.assign(component: physicsComponent)

        return wall
    }

    @discardableResult
    func createPeg(at position: CGPoint, of size: CGSize, index: Int) -> Entity {
        let peg = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.peg)
            PegComponent()
            OscillationComponent(centerOfOscillation: position,
                                 axis: AXOscillation.verticalAxis, amplitude: AXOscillation.pegAmplitude[index],
                                 period: AXOscillation.pegPeriod[index],
                                 displacement: Double.random(in: 0...Double.pi))
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

    @discardableResult
    func createLava(at position: CGPoint, of size: CGSize) -> Entity {
        let lava = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.lava)
        }

        let physicsComponent = physicsCreator.createLava(of: size, for: lava.id)
        lava.assign(component: physicsComponent)

        return lava
    }

    @discardableResult
    func createLavaSmoke(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: AXAssets.lava)
            animationCreator.createLavaSmokeAnimation()
        }
    }
}
