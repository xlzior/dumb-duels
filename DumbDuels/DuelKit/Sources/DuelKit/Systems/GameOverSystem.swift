//
//  GameOverSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 27/3/23.
//

import CoreGraphics

class GameOverSystem: InternalSystem {
    var priority: InternalSystemOrder = .gameOver

    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer
    private var onGameOver: () -> Void

    private let assets: GameOverAssets

    private var players: Assemblage1<ScoreComponent>
    private var winningScore: Int

    init(for entityManager: EntityManager, eventFirer: EventFirer,
         onGameOver: @escaping () -> Void,
         assets: GameOverAssets, winningScore: Int) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.players = entityManager.assemblage(requiredComponents: ScoreComponent.self)
        self.onGameOver = onGameOver
        self.assets = assets
        self.winningScore = winningScore
    }

    func update() {
        checkWin()
    }

    @discardableResult
    func checkWin() -> Bool {
        var winningEntities = [Int: EntityID]()

        for score in players where score.score >= winningScore {
            winningEntities[score.playerIndex] = score.playerId
        }

        guard let winner = winningEntities.first?.value else {
            return false
        }

        if winningEntities.count > 1 {
            eventFirer.fire(GameTieEvent())
        } else {
            eventFirer.fire(GameWonEvent(entityId: winner))
        }

        return true
    }

    func handleGameStart() {
        if checkWin() {
            return
        }
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

extension GameOverSystem {
    private func createGameOverText(at position: CGPoint, of size: CGSize, displaying text: String) {
        entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: text)
            SoundComponent(sounds: ["game-end": assets.gameEndSound()])
        }
    }

    private func createBattleFlashAnimation() -> AnimationComponent {
        AnimationComponent(
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
            numRepeat: 2,
            shouldDestroyEntityOnEnd: true
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

}
