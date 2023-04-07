//
//  CannonballHitTankEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit

struct CannonballHitTankEvent: Event {
    var priority = 2

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: TAScoreSystem.self) else {
            return
        }

        scoreSystem.handleCannonballHitPlayer(entityId: entityId)
    }
}
