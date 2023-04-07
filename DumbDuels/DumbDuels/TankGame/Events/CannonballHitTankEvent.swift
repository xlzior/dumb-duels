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
        guard let scoreSystem = systems.get(ofType: TAScoreSystem.self),
              let roundSystem = systems.get(ofType: TARoundSystem.self),
              let cannonballSystem = systems.get(ofType: CannonballSystem.self) else {
            return
        }

        scoreSystem.handleCannonballHitPlayer(entityId: entityId)
        cannonballSystem.removeAllCannonballs()
        roundSystem.reset()
    }
}
