//
//  RenderSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

class RenderSystem: System {
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
    var players: Assemblage2<PlayerComponent, ScoreComponent>

    init(for entityManager: EntityManager, eventManger: EventManager, details: RenderSystemDetails) {
        self.entityManager = entityManager
        self.gameController = details.gameController
        self.screenSize = details.screenSize
        self.screenOffset = details.screenOffset
        self.renderables = entityManager.assemblage(requiredComponents: SpriteComponent.self,
            PositionComponent.self, SizeComponent.self, RotationComponent.self)
        self.players = entityManager.assemblage(requiredComponents: PlayerComponent.self, ScoreComponent.self)
    }

    func update() {
        renderEntities()
        renderScores()
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
                centerPosition: newPosition,
                width: size.originalSize.width * size.xScale * scalingFactor,
                height: size.originalSize.height * size.yScale * scalingFactor,
                rotation: rotation.angleInRadians
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
    }

    private func renderScores() {
        for (entity, _, score) in players.entityAndComponents {
            gameController.updateScore(for: entity.id, with: score.score)
        }
    }
}
