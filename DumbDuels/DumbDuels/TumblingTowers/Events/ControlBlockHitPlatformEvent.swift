//
//  ControlBlockHitPlatformEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

struct ControlBlockHitPlatformEvent: Event {
    var priority = 2 // TODO: check this priority

    var controlBlockId: EntityID

    func execute(with systems: SystemManager) {
        guard let blockSpawnSystem = systems.get(ofType: BlockSpawnSystem.self) else {
            return
        }

        blockSpawnSystem.handleBlockCollisionWithPlatform(for: controlBlockId)
    }
}
