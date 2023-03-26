//
//  EntityCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

class EntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: PhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = PhysicsCreator(entityManager: entityManager)
    }

    func createAxe(at position: CGPoint, of size: CGSize) -> Entity {
        let axe = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "axe")
            AxeComponent()
        }
//        let collidable = physicsCreator.axeCollidable(axeId: axe.id)
//        let physicsComponent = physicsCreator.createAxe(of: size)
//        axe.assign(component: collidable)
//        axe.assign(component: physicsComponent)
        return axe
    }

    func createAxe(withHorizontalOffset offset: CGFloat, from position: CGPoint, of size: CGSize) -> Entity {
        let axePosition = CGPoint(x: position.x + offset, y: position.y)
        let axe = entityManager.createEntity {
            PositionComponent(position: axePosition)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "axe")
            AxeComponent()
        }
//        let collidable = physicsCreator.axeCollidable(axeId: axe.id)
//        let physicsComponent = physicsCreator.createAxe(of: size)
//        axe.assign(component: collidable)
//        axe.assign(component: physicsComponent)
        return axe
    }

    func createPlayer(
        index: Int,
        at position: CGPoint,
        facing faceDirection: FaceDirection,
        of size: CGSize,
        holding axeEntityID: EntityID,
        onPlatform platformId: EntityID
    ) -> Entity {
        let player = entityManager.createEntity {
            PositionComponent(position: position, faceDirection: faceDirection)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "player")
            ScoreComponent()
            CanJumpComponent()
            SyncXPositionComponent(syncFrom: platformId)
        }
        let physicsComponent = physicsCreator.createPlayer(of: size, for: player.id)
        player.assign(component: physicsComponent)

        // TODO: Refactor hit animation
        let animationComponent = AnimationComponent(
            isPlaying: false,
            frames: [AnimationFrame(
                frameDuration: 0.5,
                spriteName: "player-flash",
                alpha: 1,
                position: position,
                xScale: 1,
                yScale: 1,
                rotationAngle: 0),
            AnimationFrame(
                frameDuration: 0.1,
                spriteName: "player",
                alpha: 1,
                position: position,
                xScale: 1,
                yScale: 1,
                rotationAngle: 0)],
            numRepeat: 0
        )
        player.assign(component: animationComponent)

        let fsm = EntityStateMachine<PlayerComponent.State>(entity: player)
        fsm.createState(name: .holdingAxe)
            .addInstance(HoldingAxeComponent(axeEntityID: axeEntityID))
        fsm.createState(name: .notHoldingAxe)

        entityManager.assign(component: PlayerComponent(fsm: fsm, idx: index), to: player)
        fsm.changeState(name: .holdingAxe)

        return player
    }

    func createPlatform(at position: CGPoint, of size: CGSize) -> Entity {
        let platform = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "platform")
            PlatformComponent()
        }
        let physicsComponent = physicsCreator.createPlatform(of: size, for: platform.id)
        platform.assign(component: physicsComponent)

        return platform
    }

    func createPlatform(withVerticalOffset offset: CGFloat, from position: CGPoint, of size: CGSize) -> Entity {
        let platformPosition = CGPoint(x: position.x, y: position.y + offset)
        let platform = entityManager.createEntity {
            PositionComponent(position: platformPosition)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "platform")
            PlatformComponent()
        }
        let physicsComponent = physicsCreator.createPlatform(of: size, for: platform.id)
        platform.assign(component: physicsComponent)

        return platform
    }

    func createWall(at position: CGPoint, of size: CGSize) -> Entity {
        let wall = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            WallComponent()
        }

        let physicsComponent = physicsCreator.createWall(of: size, for: wall.id)
        wall.assign(component: physicsComponent)

        return wall
    }

    func createBattleText(at position: CGPoint, of size: CGSize) -> Entity {
        let battleText = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "battle")
        }

        let animationComponent = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.05,
                    spriteName: "battle",
                    alpha: 0,
                    position: position,
                    xScale: 1,
                    yScale: 1,
                    rotationAngle: 0),
                AnimationFrame(
                    frameDuration: 0.1,
                spriteName: "battle",
                alpha: 1,
                position: position,
                xScale: 1,
                yScale: 1,
                rotationAngle: 0),
             AnimationFrame(
                frameDuration: 0.1,
                 spriteName: "battle",
                 alpha: 1,
                 position: position,
                 xScale: 1,
                 yScale: 1,
                 rotationAngle: 0),
            AnimationFrame(
                frameDuration: 0.05,
                spriteName: "battle",
                alpha: 0,
                position: position,
                xScale: 1,
                yScale: 1,
                rotationAngle: 0)],
            numRepeat: 2
        )
        battleText.assign(component: animationComponent)

        return battleText
    }
}
