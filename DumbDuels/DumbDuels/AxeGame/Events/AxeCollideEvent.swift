//
//  AxeCollideEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 8/4/23.
//

import DuelKit

struct AxeCollideEvent: Event {
    var priority = 2

    var axeEntityId: EntityID

    func execute(with systems: SystemManager) {
        guard let axeCollideSystem = systems.get(ofType: AxeCollideSystem.self) else {
            return
        }

        axeCollideSystem.playCollideSound(axeEntityId: axeEntityId)
    }
}
