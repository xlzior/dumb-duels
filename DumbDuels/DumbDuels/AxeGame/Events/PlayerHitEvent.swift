//
//  PlayerHitEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

struct PlayerHitEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID
    var hitBy: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: ScoreSystem.self) else {
            return
        }

        scoreSystem.handleAxeHitPlayer(withEntityId: entityId)
    }
}
