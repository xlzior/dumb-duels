//
//  ButtonUpEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct ButtonUpEvent: Event {
    var priority: EventPriority = .input

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        systems.inputSystem?.handleButtonUp(entityId: entityId)
    }
}
