//
//  ThrowAxeEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct ThrowAxeEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID
    
    // TODO: (sprint 2) scale to represent how hard to throw the axe

    func execute(with systems: SystemManager) {
        guard let physicsSystem: PhysicsSystem = systems.get() else {
            return
        }

        // TODO: need to figure out whether throw left or throw right
        physicsSystem.applyImpulse(to: entityId)
    }
}
