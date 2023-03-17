//
//  PhysicsSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class PhysicsSystem: System {
    var entityManager: EntityManager

    init(for entityManager: EntityManager, eventManager: EventManager) {
        self.entityManager = entityManager
    }

    func update() {

    }

    func applyImpulse(_ force: CGVector, to entityId: EntityID) {

    }
}
