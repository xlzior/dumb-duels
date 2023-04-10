//
//  GameWonEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 17/3/23.
//

struct GameWonEvent: Event {
    var priority = 4

    var entityId: EntityID

    init(priority: Int = 4, entityId: EntityID) {
        self.priority = priority
        self.entityId = entityId
    }

    func execute(with systems: SystemManager) {
        guard let gameOverSystem = systems.get(ofType: GameOverSystem.self),
              let renderSystem = systems.get(ofType: RenderSystem.self) else {
            return
        }
        gameOverSystem.handleGameWon(by: entityId)
        renderSystem.handleGameOver()
    }
}
