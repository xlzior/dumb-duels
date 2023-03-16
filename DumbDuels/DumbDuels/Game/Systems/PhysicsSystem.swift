//
//  PhysicsSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class PhysicsSystem: System {
    var entityManager: EntityManager

    init(for entityManager: EntityManager, eventManger: EventManager) {
        self.entityManager = entityManager
    }

    func update() {

    }

    func applyImpulse(to entityId: EntityID) {

    }
}
