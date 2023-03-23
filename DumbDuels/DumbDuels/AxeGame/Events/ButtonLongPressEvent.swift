//
//  ButtonLongPressEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

enum GestureState {
    case start
    case end
}

struct ButtonLongPressEvent: Event {
    var priority: EventPriority = .input

    var entityId: EntityID

    var state: GestureState

    func execute(with systems: SystemManager) {
        guard let inputSystem = systems.get(ofType: InputSystem.self) else {
            return
        }

        inputSystem.handleButtonLongPress(entityId: entityId, state: state)
    }
}
