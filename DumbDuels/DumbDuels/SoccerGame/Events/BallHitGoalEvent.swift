//
//  BallHitGoalEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import DuelKit

struct BallHitGoalEvent: Event {
    var priority: Int = 4

    var goalId: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: SOScoreSystem.self),
              let animationSystem = systems.get(ofType: SOAnimationSystem.self),
              let roundSystem = systems.get(ofType: SORoundSystem.self) else {
            return
        }

        scoreSystem.handleBallHitGoal(goalId: goalId)
        animationSystem.goalAnimation(goalId: goalId)
        roundSystem.reset()
    }
}
