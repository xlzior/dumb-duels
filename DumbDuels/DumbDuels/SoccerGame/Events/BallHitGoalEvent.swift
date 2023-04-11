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
        guard let scoreSystem = systems.get(ofType: SOScoreSystem.self) else {
            return
        }

        scoreSystem.handleBallHitGoal(goalId: goalId)
    }
}
