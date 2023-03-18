//
//  JumpEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct JumpEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let playerAxeSystem = systems.get(ofType: PlayerAxeSystem.self) else {
            return
        }

        playerAxeSystem.jump(playerId: entityId)
    }
}
