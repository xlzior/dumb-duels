//
//  CannonballHitTankEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit

struct CannonballHitTankEvent: Event {
    var priority = 2

    var cannonballId: EntityID
    var tankId: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: TAScoreSystem.self),
              let roundSystem = systems.get(ofType: TARoundSystem.self),
              let cannonballSystem = systems.get(ofType: CannonballSystem.self) else {
            return
        }

        let didIncrementScore = scoreSystem.handleCannonballHitPlayer(
            cannonballId: cannonballId, playerId: tankId)

        if didIncrementScore {
            cannonballSystem.removeAllCannonballs()
            roundSystem.reset()
        }
    }
}
