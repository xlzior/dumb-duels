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
        guard let inputSystem: InputSystem = systems.get() else {
            return
        }

        inputSystem.handleButtonPress(entityId: entityId)
    }
}
