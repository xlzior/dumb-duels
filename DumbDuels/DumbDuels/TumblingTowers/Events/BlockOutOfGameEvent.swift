//
//  BlockOutOfGameEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 14/4/23.
//

import DuelKit

struct BlockOutOfGameEvent: Event {
    var priority = 2

    var blockId: EntityID

    func execute(with systems: SystemManager) {
        guard let blockSpawnSystem = systems.get(ofType: BlockSpawnSystem.self) else {
            return
        }

        blockSpawnSystem.removeAndCleanupBlock(blockId: blockId)
    }
}
