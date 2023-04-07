//
//  TAScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit

class TAScoreSystem: System {
    private let entityManager: EntityManager
    private let tanks: Assemblage2<TankComponent, ScoreComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.tanks = entityManager.assemblage(requiredComponents: TankComponent.self, ScoreComponent.self)
    }

    func update() {

    }

    func handleCannonballHitPlayer(entityId: EntityID) {
        for (tank, _, score) in tanks.entityAndComponents where tank.id != entityId {
            score.score += 1
        }
    }
}
