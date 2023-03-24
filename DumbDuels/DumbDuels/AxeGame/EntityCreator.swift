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

    func createAxe(
        withHorizontalOffset offset: CGFloat,
        from position: CGPoint,
        of size: CGSize,
        facing: FaceDirection) -> Entity {
        let axePosition = CGPoint(x: position.x + offset, y: position.y)
        let axe = entityManager.createEntity {
            PositionComponent(position: axePosition, faceDirection: facing)
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

    func createThrowStrength(at position: CGPoint) -> Entity {
        let throwStrength = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: CGSize(width: 75, height: 30))
        }

        let fsm = EntityStateMachine<ThrowStrengthComponent.State>(entity: throwStrength)
        fsm.createState(name: .charging)
            .addInstance(SpriteComponent(assetName: "chargingBar"))
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
            SpriteComponent(assetName: "player")
            ScoreComponent()
            CanJumpComponent()
            SyncXPositionComponent(syncFrom: platformId)
            WithThrowStrengthComponent(throwStrengthEntityId: throwStrengthEntity.id)
        }
        let physicsComponent = physicsCreator.createPlayer(of: size, for: player.id)
        player.assign(component: physicsComponent)

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
}
