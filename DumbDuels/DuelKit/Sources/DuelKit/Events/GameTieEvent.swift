//
//  GameTieEvent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 27/3/23.
//

struct GameTieEvent: Event {
    var priority = 4

    init(priority: Int = 4) {
        self.priority = priority
    }

    func execute(with systems: SystemManager) {
        guard let gameOverSystem = systems.get(ofType: GameOverSystem.self),
              let renderSystem = systems.get(ofType: RenderSystem.self) else {
            return
        }
        gameOverSystem.handleGameTied()
        renderSystem.handleGameOver()
    }
}
