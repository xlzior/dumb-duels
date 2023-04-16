//
//  SOScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import DuelKit

class SOScoreSystem: System {
    unowned var entityManager: EntityManager

    private let goals: Assemblage1<GoalComponent>
    private let players: Assemblage1<ScoreComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.players = entityManager.assemblage(requiredComponents: ScoreComponent.self)
        self.goals = entityManager.assemblage(requiredComponents: GoalComponent.self)
    }

    func update() {

    }

    func handleBallHitGoal(goalId: EntityID) {
        guard let goal = goals.getComponents(for: goalId) else {
            return
        }
        for (entity, score) in players.entityAndComponents where entity.id == goal.attackerId {
            score.score += 1
        }
    }
}
