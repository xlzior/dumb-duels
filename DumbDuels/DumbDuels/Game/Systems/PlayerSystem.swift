//
//  PlayerSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class PlayerSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventManger: EventManager

    init(for entityManager: EntityManager, eventManger: EventManager) {
        self.entityManager = entityManager
        self.eventManger = eventManger
    }

    func update() {

    }

    func handleButtonPress(entityId: EntityID) {
        let hasAxe = entityManager.has(componentTypeId: HoldingAxeComponent.typeId, entityId: entityId)

        if !hasAxe {
            return eventManger.fire(JumpEvent(entityId: entityId))
        }

        guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(
            ofType: HoldingAxeComponent.typeId,
            for: entityId) else {
            return
        }
        eventManger.fire(ThrowAxeEvent(entityId: holdingAxe.axeEntityID))
    }
}
