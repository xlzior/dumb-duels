//
//  ButtonPressEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct ButtonPressEvent: Event {
    var priority: EventPriority = .input

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        guard let playerSystem = systems.get(ofType: PlayerSystem.self) else {
            return
        }

        playerSystem.handleButtonPress(entityId: entityId)
    }
}
