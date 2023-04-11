//
//  BlockHitBlockEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

struct BlockHitBlockEvent: Event {
    var priority = 2 // TODO: check this priority

    var controlBlockId: EntityID
    var landedBlockId: EntityID

    func execute(with systems: SystemManager) {
        guard let blockSpawnSystem = systems.get(ofType: BlockSpawnSystem.self) else {
            return
        }

        blockSpawnSystem.handleBlockCollision(controlBlockId: controlBlockId, landedBlockId: landedBlockId)
    }
}
