//
//  GameWonEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 17/3/23.
//

import DuelKit

struct GameWonEvent: Event {
    var priority = 2

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        print("Game won by \(entityId)")
    }
}
