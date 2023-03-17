//
//  GameWonEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 17/3/23.
//

struct GameWonEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        print("Game won by \(entityId)")
    }
}
