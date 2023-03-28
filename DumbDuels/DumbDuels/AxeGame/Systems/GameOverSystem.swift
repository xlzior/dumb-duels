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

    private var players: Assemblage4<PlayerComponent, ScoreComponent, PositionComponent, PhysicsComponent>

    init(for entityManager: EntityManager, entityCreator: EntityCreator) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.players = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, ScoreComponent.self,
            PositionComponent.self, PhysicsComponent.self)
    }

    func update() {}

    func handleGameTied() {
        entityCreator.createGameOverText(at: Positions.text, of: Sizes.gameTiedText, displaying: Assets.gameTiedText)
    }

    func handleGameWon(by entityId: EntityID) {
        for (entity, player, _, _, _) in players.entityAndComponents {
            guard entity.id == entityId else {
                continue
            }
            entityCreator.createGameOverText(
                at: Positions.text, of: Sizes.gameWonText, displaying: Assets.gameWonText[player.idx])
        }
    }
}
