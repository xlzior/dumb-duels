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
    private let tanks: Assemblage3<TankComponent, ScoreComponent, PositionComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.tanks = entityManager.assemblage(
            requiredComponents: TankComponent.self, ScoreComponent.self,
            PositionComponent.self)
    }

    func update() {

    }

    func reset() {
        let (position1, position2) = TAPositions.randomTankPositions()
        for (tank, _, position) in tanks {
            tank.isMoving = false
            tank.chargingSince = nil
            tank.fsm.changeState(name: .charging0)
            position.position = tank.index == 0 ? position1 : position2
        }

        eventFirer.fire(GameStartEvent())
    }
}
