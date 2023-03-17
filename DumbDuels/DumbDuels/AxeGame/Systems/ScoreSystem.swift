//
//  ScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class ScoreSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventManager: EventManager

    private var players: Assemblage2<PlayerComponent, ScoreComponent>

    init(for entityManager: EntityManager, eventManager: EventManager) {
        self.entityManager = entityManager
        self.eventManager = eventManager
        self.players = entityManager.assemblage(requiredComponents: PlayerComponent.self,
                                                ScoreComponent.self)
    }

    func update() {
        for (player, _, score) in players.entityAndComponents where score.score == 5 {
            eventManager.fire(GameWonEvent(entityId: player.id))
        }
    }

    func handleAxeHitPlayer(withEntityId entityId: EntityID) {
        for (player, _, score) in players.entityAndComponents where player.id != entityId {
            score.score += 1
        }
    }
}
