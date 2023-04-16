//
//  SOAnimationSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 12/4/23.
//

import DuelKit

class SOAnimationSystem: System {
    unowned var entityManager: EntityManager

    private let goals: Assemblage1<GoalComponent>
    private let players: Assemblage2<SoccerPlayerComponent, AnimationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.goals = entityManager.assemblage(requiredComponents: GoalComponent.self)
        self.players = entityManager.assemblage(requiredComponents: SoccerPlayerComponent.self, AnimationComponent.self)
    }

    func update() {}

    func goalAnimation(goalId: EntityID) {
        guard let goal = goals.getComponents(for: goalId) else {
            return
        }

        for (entity, _, animation) in players.entityAndComponents where entity.id == goal.attackerId {
            animation.isPlaying = true
        }
    }
}
