//
//  GameOverSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 27/3/23.
//

import CoreGraphics

class GameOverSystem: System {
    unowned var entityManager: EntityManager
    private var onGameOver: () -> Void

    private let assets: GameOverAssets

    private var players: Assemblage1<ScoreComponent>

    private func createGameOverText(at position: CGPoint, of size: CGSize, displaying text: String) {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: text)
            SoundComponent(sounds: ["game-end": assets.gameEndSound()])
        }
    }

    func createBattleFlashAnimation() -> AnimationComponent {
        AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.05,
                    alpha: 0)],
            numRepeat: 2
        )
    }

    private func createGameStartText(at position: CGPoint, of size: CGSize) {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: assets.gameStartText)
            SoundComponent(sounds: ["battle": assets.gameStartSound()])
            createBattleFlashAnimation()
        }
    }

    init(for entityManager: EntityManager, onGameOver: @escaping () -> Void, assets: GameOverAssets) {
        self.entityManager = entityManager
        self.players = entityManager.assemblage(requiredComponents: ScoreComponent.self)
        self.onGameOver = onGameOver
        self.assets = assets
    }

    func update() {}

    func handleGameStart() {
        createGameStartText(at: Positions.text, of: Sizes.battleText)
    }

    func handleGameTied() {
        createGameOverText(
            at: Positions.text,
            of: Sizes.gameTiedText,
            displaying: assets.gameTieText)
        onGameOver()
    }

    func handleGameWon(by entityId: EntityID) {
        guard let score = players.getComponents(for: entityId) else {
            return
        }
        createGameOverText(
            at: Positions.text,
            of: Sizes.gameWonText,
            displaying: assets.gameWonTexts[score.playerIndex])
        onGameOver()
    }
}
