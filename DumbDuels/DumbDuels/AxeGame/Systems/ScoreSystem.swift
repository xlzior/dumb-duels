//
//  ScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import DuelKit

class ScoreSystem: System {
    unowned var entityManager: EntityManager

    private var players: Assemblage2<PlayerComponent, ScoreComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.players = entityManager.assemblage(requiredComponents: PlayerComponent.self,
                                                ScoreComponent.self)
    }

    func update() {

    }

    func handleAxeHitPlayer(withEntityId entityId: EntityID) {
        for (player, _, score) in players.entityAndComponents where player.id != entityId {
            score.score += 1
        }
    }
}
