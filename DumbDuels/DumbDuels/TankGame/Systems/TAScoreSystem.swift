//
//  TAScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import Foundation
import DuelKit

class TAScoreSystem: System {
    private let entityManager: EntityManager
    private let tanks: Assemblage2<TankComponent, ScoreComponent>
    private let cannonballs: Assemblage1<CannonballComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.tanks = entityManager.assemblage(requiredComponents: TankComponent.self, ScoreComponent.self)
        self.cannonballs = entityManager.assemblage(requiredComponents: CannonballComponent.self)
    }

    func update() {

    }

    func handleCannonballHitPlayer(cannonballId: EntityID, playerId: EntityID) -> Bool {
        guard let cannonball = cannonballs.getComponents(for: cannonballId) else {
            return false
        }

        if cannonball.playerId == playerId && Date() < cannonball.immunityUntil {
            return false
        }

        for (tank, _, score) in tanks.entityAndComponents where tank.id != playerId {
            score.score += 1
        }

        return true
    }
}
