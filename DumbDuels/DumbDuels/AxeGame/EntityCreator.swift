//
//  EntityCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

class EntityCreator {
    private let entityManager: EntityManager

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
    }

    func createAxe(at position: CGPoint, of size: CGSize) -> Entity {
        let axe = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: "axe")
            AxeComponent()
        }
        let axeCategory = AxeCategory(entityId: axe.id)
        axe.assign(component: CollidableComponent(categories: axeCategory))
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
        }
        let playerCategory = PlayerCategory(entityId: player.id)
        entityManager.assign(component: CollidableComponent(categories: playerCategory), to: player)

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
        let platformCategory = PlatformCategory(entityId: platform.id)
        entityManager.assign(component: CollidableComponent(categories: platformCategory), to: platform)
        return platform
    }
}
