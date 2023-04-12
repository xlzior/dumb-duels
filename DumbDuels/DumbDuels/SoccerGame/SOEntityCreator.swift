//
//  SOEntityCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

class SOEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: SOPhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = SOPhysicsCreator()
    }

    @discardableResult
    func createPlayer(index: Int, at position: CGPoint, of size: CGSize, rotation: CGFloat) -> Entity {
        let player = entityManager.createEntity {
            SoccerPlayerComponent(index: index)
            PositionComponent(position: position)
            RotationComponent(angleInRadians: rotation)
            SizeComponent(originalSize: size)
            AutoRotateComponent(by: SOConstants.rotationSpeed)
            SpriteComponent(assetName: SOAssets.players[index])
            WillExplodeParticlesComponent(
                particles: SOAssets.particles,
                numExplodingParticles: 1,
                travelDistanceRange: 10...50
            )
            physicsCreator.createPlayer(of: size)
        }

        player.assign(component: ScoreComponent(for: index, withId: player.id))

        return player
    }

    @discardableResult
    func createBall(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            BallComponent()
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: SOAssets.ball)
            physicsCreator.createBall(of: size)
        }
    }

    @discardableResult
    func createGoal(attackerId: EntityID, at position: CGPoint, of size: CGSize, thickness: CGFloat, facing: FaceDirection) -> [Entity] {
        let sprite = entityManager.createEntity {
            PositionComponent(position: position, faceDirection: facing)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: SOAssets.goal, zPosition: 1)
            physicsCreator.createGoal(of: size)
        }

        let backWallSize = CGSize(width: thickness, height: size.height)
        let backWallOffset = facing.rawValue * CGVector(dx: -size.width / 2, dy: 0)

        let back = entityManager.createEntity {
            GoalComponent(attackerId: attackerId)
            PositionComponent(position: position + backWallOffset)
            RotationComponent()
            SizeComponent(originalSize: backWallSize)
            physicsCreator.createGoalBack(of: backWallSize)
        }

        let sideWallSize = CGSize(width: size.width, height: thickness)
        let topOffset = CGVector(dx: 0, dy: size.height / 2)
        let bottomOffset = CGVector(dx: 0, dy: -size.height / 2)

        let top = entityManager.createEntity {
            GoalComponent(attackerId: attackerId)
            PositionComponent(position: position + topOffset)
            RotationComponent()
            SizeComponent(originalSize: sideWallSize)
            physicsCreator.createGoalSide(of: sideWallSize)
        }

        let bottom = entityManager.createEntity {
            GoalComponent(attackerId: attackerId)
            PositionComponent(position: position + bottomOffset)
            RotationComponent()
            SizeComponent(originalSize: sideWallSize)
            physicsCreator.createGoalSide(of: sideWallSize)
        }

        return [sprite, back, top, bottom]
    }

    @discardableResult
    func createWall(at position: CGPoint, of size: CGSize, rotation: CGFloat) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent(angleInRadians: rotation)
            SizeComponent(originalSize: size)
            physicsCreator.createWall(of: size)
        }
    }
}
