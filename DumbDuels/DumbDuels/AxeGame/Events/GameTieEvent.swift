//
//  GameTieEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 27/3/23.
//

import DuelKit

struct GameTieEvent: Event {
    var priority = 2

    func execute(with systems: SystemManager) {
        guard let gameOverSystem = systems.get(ofType: GameOverSystem.self),
              let renderSystem = systems.get(ofType: RenderSystem.self) else {
            return
        }
        gameOverSystem.handleGameTied()
        renderSystem.handleGameOver()
    }
}
