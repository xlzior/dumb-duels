//
//  SPGameTieEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 30/3/23.
//

import DuelKit

struct SPGameTieEvent: Event {
    var priority = 2

    func execute(with systems: SystemManager) {
        guard let gameOverSystem = systems.get(ofType: SPGameOverSystem.self),
              let renderSystem = systems.get(ofType: RenderSystem.self) else {
            return
        }
        gameOverSystem.handleGameTied()
        renderSystem.handleGameOver()
    }
}
