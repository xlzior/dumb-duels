//
//  TARoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit

class TARoundSystem: System {
    private let entityManager: EntityManager
    private let eventFirer: EventFirer
    private let tanks: Assemblage2<TankComponent, ScoreComponent>
    private var isGameOver = false

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.tanks = entityManager.assemblage(requiredComponents: TankComponent.self, ScoreComponent.self)
    }

    // TODO: logic is duplicated in every game; refactor into duelkit
    func checkWin() {
        var winningEntities = [EntityID]()
        for (entity, _, score) in tanks.entityAndComponents
        where score.score >= TAConstants.winningScore {
            winningEntities.append(entity.id)
        }

        guard !winningEntities.isEmpty else {
            return
        }

        if winningEntities.count > 1 {
            eventFirer.fire(GameTieEvent())
        } else {
            eventFirer.fire(GameWonEvent(entityId: winningEntities[0]))
        }
        isGameOver = true
    }

    func update() {

    }

    func reset() {
        checkWin()

        // TODO: reset tanks to random starting positions

        if !isGameOver {
            eventFirer.fire(GameStartEvent())
        }
    }
}
