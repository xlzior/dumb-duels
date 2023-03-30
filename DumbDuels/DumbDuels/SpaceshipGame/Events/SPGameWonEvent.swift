//
//  SPGameWonEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 30/3/23.
//

import DuelKit

struct SPGameWonEvent: Event {
    var priority = 4

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let gameOverSystem = systems.get(ofType: SPGameOverSystem.self),
              let renderSystem = systems.get(ofType: RenderSystem.self) else {
            return
        }
        gameOverSystem.handleGameWon(by: entityId)
        renderSystem.handleGameOver()
    }
}
