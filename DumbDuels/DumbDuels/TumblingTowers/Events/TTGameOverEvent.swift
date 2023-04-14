//
//  TTGameOverEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 14/4/23.
//

import DuelKit

struct TTGameOverEvent: Event {
    // Needs to be last, otherwise after resetting, other events can execute to
    // change control block velocity etc.
    var priority = 4

    func execute(with systems: SystemManager) {
        guard let blockSpawnSystem = systems.get(ofType: BlockSpawnSystem.self),
              let inputSystem = systems.get(ofType: TTInputSystem.self) else {
            return
        }

        blockSpawnSystem.handleGameOver()
        inputSystem.handleGameOver()

    }
}
