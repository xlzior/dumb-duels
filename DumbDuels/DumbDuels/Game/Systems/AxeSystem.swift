//
//  AxeSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class AxeSystem: System {
    var entityManager: EntityManager
    var eventManger: EventManager

    init(for entityManager: EntityManager, eventManger: EventManager) {
        self.entityManager = entityManager
        self.eventManger = eventManger
    }

    func update() {
        // get both axes (via assemblage)
        // check the Position component of both axes
        // if they're both off screen, reset the round (fire a ResetRound Event)
    }
}
