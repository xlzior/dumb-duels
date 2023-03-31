//
//  GameOverSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 27/3/23.
//

import DuelKit

class GameOverSystem: System {
    unowned var entityManager: EntityManager
    unowned var entityCreator: EntityCreator
    private var onGameOver: () -> Void

    // TODO: game specific, think about how to move it in
    private var players: Assemblage4<PlayerComponent, ScoreComponent, PositionComponent, PhysicsComponent>

    init(for entityManager: EntityManager, entityCreator: EntityCreator, onGameOver: @escaping () -> Void) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.players = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, ScoreComponent.self,
            PositionComponent.self, PhysicsComponent.self)
        self.onGameOver = onGameOver
    }

    func update() {}

    func handleGameTied() {
        entityCreator.createGameOverText(at: Positions.text, of: AXSizes.gameTiedText, displaying: Assets.gameTiedText)
        onGameOver()
    }

    func handleGameWon(by entityId: EntityID) {
        for (entity, player, _, _, _) in players.entityAndComponents where entity.id == entityId {
            entityCreator.createGameOverText(
                at: Positions.text, of: AXSizes.gameWonText, displaying: Assets.gameWonText[player.idx])
            onGameOver()
        }
    }
}
