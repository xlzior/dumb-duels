//
//  ScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class ScoreSystem: System {
    var entityManager: EntityManager

    init(for entityManager: EntityManager, eventManger: EventManager) {
        self.entityManager = entityManager
    }

    func update() {
        // get all the Players (via assemblage)
        // check the score component for all
        // if one player's score == 5, trigger game over (fire GameOverEvent)
    }

    func increment(for entityId: EntityID) {
        guard let scoreComponent: ScoreComponent = entityManager.getComponent(
            ofType: ScoreComponent.typeId,
            for: entityId) else {
            return
        }
        scoreComponent.score += 1
    }
}
