//
//  JumpEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct JumpEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let physicsSystem = systems.get(ofType: PhysicsSystem.self) else {
            return
        }

        // TODO: don't allow double jumps
        physicsSystem.applyImpulse(to: entityId)
    }
}
