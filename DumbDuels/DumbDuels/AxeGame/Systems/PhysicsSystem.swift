//
//  PhysicsSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class PhysicsSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventManager: EventManager

    init(for entityManager: EntityManager, eventManager: EventManager) {
        self.entityManager = entityManager
        self.eventManager = eventManager
    }

    func update() {

    }

    func applyImpulse(_ force: CGVector, to entityId: EntityID) {

    }
}
