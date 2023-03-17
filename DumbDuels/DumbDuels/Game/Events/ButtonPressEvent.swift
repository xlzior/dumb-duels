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
        // TODO: WJ FIX PLS < 3
        guard let playerSystem: PlayerSystem = systems.get() else {
            return
        }

        playerSystem.handleButtonPress(entityId: entityId)
    }
}
