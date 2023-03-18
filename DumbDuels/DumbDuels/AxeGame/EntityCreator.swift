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
        let collidable = physicsCreator.axeCollidable(axeId: axe.id)
        let physicsComponent = physicsCreator.createAxe(of: size)
        axe.assign(component: collidable)
        axe.assign(component: physicsComponent)
        print("Axe \(axe.id) collidable bitmask: \(ColliisionUtils.bitmasks(for: collidable.categories))")
        print("Axe \(axe.id) collidable CollideBitmask: \(ColliisionUtils.collideBitmasks(for: collidable.categories))")
        print("Axe \(axe.id) collidable ContactBitmask: \(ColliisionUtils.contactBitmasks(for: collidable.categories))")

        print("Axe \(axe.id) physics bitmask: \(physicsComponent.categoryBitMask)")
        print("Axe \(axe.id) physics CollideBitmask: \(physicsComponent.collisionBitMask)")
        print("Axe \(axe.id) physics ContactBitmask: \(physicsComponent.contactTestBitMask)")
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
        let collidable = physicsCreator.axeCollidable(axeId: axe.id)
        let physicsComponent = physicsCreator.createAxe(of: size)
        axe.assign(component: collidable)
        axe.assign(component: physicsComponent)
        print("Axe \(axe.id) collidable bitmask: \(ColliisionUtils.bitmasks(for: collidable.categories))")
        print("Axe \(axe.id) collidable CollideBitmask: \(ColliisionUtils.collideBitmasks(for: collidable.categories))")
        print("Axe \(axe.id) collidable ContactBitmask: \(ColliisionUtils.contactBitmasks(for: collidable.categories))")

        print("Axe \(axe.id) physics bitmask: \(physicsComponent.categoryBitMask)")
        print("Axe \(axe.id) physics CollideBitmask: \(physicsComponent.collisionBitMask)")
        print("Axe \(axe.id) physics ContactBitmask: \(physicsComponent.contactTestBitMask)")
        return axe
    }

    func createPlayer(
        at position: CGPoint,
        facing faceDirection: FaceDirection,
        of size: CGSize,
        holding axeEntityID: EntityID
    ) -> Entity {
        let player = entityManager.createEntity {
            PositionComponent(position: position, faceDirection: faceDirection)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "player")
            ScoreComponent()
            CanJumpComponent()
        }
        let collidable = physicsCreator.playerCollidable(playerId: player.id)
        let physicsComponent = physicsCreator.createPlayer(of: size)
        player.assign(component: collidable)
        player.assign(component: physicsComponent)
        print("Player \(player.id) collidable bitmask: \(ColliisionUtils.bitmasks(for: collidable.categories))")
        print("Player \(player.id) collidable CollideBitmask: \(ColliisionUtils.collideBitmasks(for: collidable.categories))")
        print("Player \(player.id) collidable ContactBitmask: \(ColliisionUtils.contactBitmasks(for: collidable.categories))")

        print("Player \(player.id) physics bitmask: \(physicsComponent.categoryBitMask)")
        print("Player \(player.id) physics CollideBitmask: \(physicsComponent.collisionBitMask)")
        print("Player \(player.id) physics ContactBitmask: \(physicsComponent.contactTestBitMask)")

        let fsm = EntityStateMachine<PlayerComponent.State>(entity: player)
        fsm.createState(name: .holdingAxe)
            .addInstance(HoldingAxeComponent(axeEntityID: axeEntityID))
        fsm.createState(name: .notHoldingAxe)

        entityManager.assign(component: PlayerComponent(fsm: fsm), to: player)
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
        let collidable = physicsCreator.platformCollidable(platformId: platform.id)
        let physicsComponent = physicsCreator.createPlatform(of: size)
        platform.assign(component: collidable)
        platform.assign(component: physicsComponent)
        print("Platform \(platform.id) collidable bitmask: \(ColliisionUtils.bitmasks(for: collidable.categories))")
        print("Platform \(platform.id) collidable CollideBitmask: \(ColliisionUtils.collideBitmasks(for: collidable.categories))")
        print("Platform \(platform.id) collidable ContactBitmask: \(ColliisionUtils.contactBitmasks(for: collidable.categories))")

        print("Platform \(platform.id) physics bitmask: \(physicsComponent.categoryBitMask)")
        print("Platform \(platform.id) physics CollideBitmask: \(physicsComponent.collisionBitMask)")
        print("Platform \(platform.id) physics ContactBitmask: \(physicsComponent.contactTestBitMask)")

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
        let collidable = physicsCreator.platformCollidable(platformId: platform.id)
        let physicsComponent = physicsCreator.createPlatform(of: size)
        platform.assign(component: collidable)
        platform.assign(component: physicsComponent)
        print("Platform \(platform.id) collidable bitmask: \(ColliisionUtils.bitmasks(for: collidable.categories))")
        print("Platform \(platform.id) collidable CollideBitmask: \(ColliisionUtils.collideBitmasks(for: collidable.categories))")
        print("Platform \(platform.id) collidable ContactBitmask: \(ColliisionUtils.contactBitmasks(for: collidable.categories))")

        print("Platform \(platform.id) physics bitmask: \(physicsComponent.categoryBitMask)")
        print("Platform \(platform.id) physics CollideBitmask: \(physicsComponent.collisionBitMask)")
        print("Platform \(platform.id) physics ContactBitmask: \(physicsComponent.contactTestBitMask)")

        return platform
    }
}
