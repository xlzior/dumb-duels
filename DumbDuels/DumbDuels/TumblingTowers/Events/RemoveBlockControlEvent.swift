//
//  RemoveBlockControlEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/4/23.
//

import DuelKit

struct RemoveBlockControlEvent: Event {
    var priority: Int = 2

    var blockIdToRemoveControl: EntityID

    func execute(with systems: SystemManager) {
        guard let inputSystem = systems.get(ofType: TTInputSystem.self) else {
            return
        }

        inputSystem.removePressMapping(controlBlockId: blockIdToRemoveControl)
    }
}
