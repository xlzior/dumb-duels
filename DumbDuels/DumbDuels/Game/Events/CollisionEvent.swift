//
//  CollisionEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct CollisionEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        // figure out what collided with what
        // (may need to break down into different types of collision events)

        // if axe collided with player, scoreSystem.increment(other player entity id)
    }
}
