//
//  TTEntityCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import Foundation
import DuelKit

class TTEntityCreator {
    private let entityManager: EntityManager
    private let physicsCreator: TTPhysicsCreator

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = TTPhysicsCreator()
    }

    @discardableResult
    func createPlayer(index: Int) -> Entity {
        let player = entityManager.createEntity {
            TTPlayerComponent(index: index)
        }
        player.assign(component: ScoreComponent(for: index, withId: player.id))
        return player
    }

    @discardableResult
    func createPlatform(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TTAssets.platform)
            TTPlatformComponent()
            physicsCreator.createPlatform(of: size)
        }
    }

    @discardableResult
    func createWall(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            physicsCreator.createWall(of: size)
        }
    }

    @discardableResult
    func createBottomBoundary(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            physicsCreator.createBottomBoundary(of: size)
        }
    }

    @discardableResult
    func createSeparator(at position: CGPoint, of size: CGSize) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TTAssets.separator)
            physicsCreator.createWall(of: size)
        }
    }

    @discardableResult
    func createBlock(ofType blockType: BlockType, at position: CGPoint, for playerId: EntityID) -> Entity {
        let blockWidth = blockType.width * TTSizes.blockUnitSize
        let blockHeight = blockType.length * TTSizes.blockUnitSize
        let blockSize = CGSize(width: blockWidth, height: blockHeight)
        let block = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: blockSize)
            SpriteComponent(assetName: blockType.assetName)
            BlockComponent(playerId: playerId)
            physicsCreator.createBlock(of: blockSize, area: blockType.width * blockType.length)
        }
        // print("Block width: \(blockWidth). Block Height: \(blockHeight)")
        let guideline = createGuideline(xPosition: position.x, width: blockWidth, for: block.id)
        block.assign(component: HasGuidelineComponent(guidelineId: guideline.id))
        return block
    }

    @discardableResult
    func createScoreLine(at position: CGPoint, of size: CGSize, for playerId: EntityID) -> Entity {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: TTAssets.scoreLine)
            ScoreLineComponent(playerId: playerId)
        }
    }

    private func createGuideline(xPosition: CGFloat, width: CGFloat, for blockId: EntityID) -> Entity {
        let guideline = entityManager.createEntity {
            PositionComponent(position: CGPoint(x: xPosition, y: Sizes.game.height / 2))
            RotationComponent()
            SizeComponent(originalSize: CGSize(width: width, height: Sizes.game.height))
            SyncXPositionComponent(syncFrom: blockId)
            SpriteComponent(assetName: TTAssets.guideline)
        }

        // print("Guideline width: \(width)")
        return guideline
    }
}
