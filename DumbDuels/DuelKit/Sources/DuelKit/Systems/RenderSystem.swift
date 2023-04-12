//
//  RenderSystem.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

// TODO: bingsen render system doesn't need to conform to IndexMapInitializable
// playerIndexToIdMap is never used
// ScoreComponent's index is used to determine which score to update
class RenderSystem: System, IndexMapInitializable {
    unowned var entityManager: EntityManager
    var gameController: GameController

    var screenSize: CGSize
    var screenOffset: CGPoint
    var scalingFactor: Double {
        let screenAspectRatio = (screenSize.width * 0.9) / (screenSize.height * 0.8)
        let gameAspectRatio = Sizes.game.width / Sizes.game.height
        let scalingFactor = screenAspectRatio > gameAspectRatio
            ? (screenSize.height * 0.8) / Sizes.game.height
            : (screenSize.width * 0.9) / Sizes.game.width
        return scalingFactor
    }

    var renderedEntities: Set<EntityID> = Set()
    var renderables: Assemblage4<SpriteComponent, PositionComponent, SizeComponent, RotationComponent>
    var playerScores: Assemblage1<ScoreComponent>
    var playerIndexToIdMap: [Int: EntityID]

    init(for entityManager: EntityManager, eventManager: EventManager, gameController: GameController) {
        self.entityManager = entityManager
        self.gameController = gameController
        self.screenSize = gameController.screenSize
        self.screenOffset = gameController.screenOffset
        self.renderables = entityManager.assemblage(
            requiredComponents: SpriteComponent.self, PositionComponent.self,
            SizeComponent.self, RotationComponent.self)
        self.playerScores = entityManager.assemblage(requiredComponents: ScoreComponent.self)
        self.playerIndexToIdMap = [Int: EntityID]()
    }

    func update() {
        renderEntities()
        renderScores()
    }

    func handleGameOver() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.gameController.goToHomePage()
        }
    }

    private func renderEntities() {
        var entitiesToRemove = renderedEntities

        for (entity, sprite, position, size, rotation) in renderables.entityAndComponents {
            // flip y-coord: maxY - currY (storyboard and spritekit diff)
            let currentPositionY = position.position.y
            let displayPositionY = Sizes.game.height - currentPositionY
            var newPosition = CGPoint(x: position.position.x, y: displayPositionY)

            // scale
            newPosition *= scalingFactor

            // add offset
            newPosition += screenOffset

            let renderDetails = RenderDetails(
                spriteName: sprite.assetName,
                alpha: sprite.alpha,
                zPosition: sprite.zPosition,
                centerPosition: newPosition,
                width: size.originalSize.width * size.xScale * scalingFactor,
                height: size.originalSize.height * size.yScale * scalingFactor,
                rotation: -rotation.angleInRadians,
                facing: position.faceDirection
            )

            if renderedEntities.contains(entity.id) {
                entitiesToRemove.remove(entity.id)
                gameController.updateView(for: entity.id, with: renderDetails)
            } else {
                renderedEntities.insert(entity.id)
                gameController.addView(for: entity.id, with: renderDetails)
            }
        }

        gameController.removeViews(for: entitiesToRemove)
        for entity in entitiesToRemove {
            renderedEntities.remove(entity)
        }
    }

    private func renderScores() {
        for score in playerScores {
            gameController.updateScore(for: score.playerIndex, with: score.score)
        }
    }
}
