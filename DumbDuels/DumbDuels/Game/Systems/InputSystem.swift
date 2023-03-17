//
//  InputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class InputSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventManager: EventManager

    init(for entityManager: EntityManager, eventManager: EventManager) {
        self.entityManager = entityManager
        self.eventManager = eventManager
    }

    func update() {

    }

    func handleButtonPress(entityId: EntityID) {
        guard let playerPosition: PositionComponent = entityManager.getComponent(
            ofType: PositionComponent.typeId,
            for: entityId) else {
            return
        }
        let playerFacing = playerPosition.faceDirection

        let hasAxe = entityManager.has(componentTypeId: HoldingAxeComponent.typeId, entityId: entityId)

        if !hasAxe {
            return eventManager.fire(JumpEvent(entityId: entityId))
        }

        guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(
            ofType: HoldingAxeComponent.typeId,
            for: entityId) else {
            return
        }
        eventManager.fire(ThrowAxeEvent(entityId: holdingAxe.axeEntityID,
                                       faceDirection: playerFacing))
    }

    func handleLongPress(entityId: EntityID) {

    }
}
