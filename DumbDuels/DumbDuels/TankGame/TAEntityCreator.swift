//
//  TAEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class TAEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: TAPhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = TAPhysicsCreator()
    }

    @discardableResult
    func createTank(index: Int, at position: CGPoint, of size: CGSize) -> Entity {
        let tank = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            AutoRotateComponent(by: TAConstants.rotationSpeed)
            physicsCreator.createTank(of: size)
        }

        let fsm = EntityStateMachine<TankComponent.State>(entity: tank)

        fsm.createState(name: .charging0)
            .addInstance(SpriteComponent(assetName: TAAssets.tankSprite(index: index, charging: 0)))
        fsm.createState(name: .charging1)
            .addInstance(SpriteComponent(assetName: TAAssets.tankSprite(index: index, charging: 1)))
        fsm.createState(name: .charging2)
            .addInstance(SpriteComponent(assetName: TAAssets.tankSprite(index: index, charging: 2)))

        fsm.changeState(name: .charging0)

        tank.assign(component: TankComponent(index: index, fsm: fsm))

        return tank
    }

    @discardableResult
    func createCannonball(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TAAssets.cannonball)
            physicsCreator.createCannonball(of: size)
        }
    }

    @discardableResult
    func createWall(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TAAssets.wall)
            physicsCreator.createWall(of: size)
        }
    }

    @discardableResult
    func createSideWall(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            physicsCreator.createSideWall(of: size)
        }
    }
}
