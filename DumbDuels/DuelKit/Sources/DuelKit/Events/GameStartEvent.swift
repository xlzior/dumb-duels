//
//  GameStartEvent.swift
//  
//
//  Created by Wen Jun Lye on 31/3/23.
//

public struct GameStartEvent: Event {
    public var priority = 4

    public init(priority: Int = 4) {
        self.priority = priority
    }

    public func execute(with systems: SystemManager) {
        guard let gameOverSystem = systems.get(ofType: GameOverSystem.self) else {
            return
        }
        gameOverSystem.handleGameStart()
    }
}
