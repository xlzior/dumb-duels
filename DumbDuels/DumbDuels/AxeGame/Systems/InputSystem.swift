//
//  InputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class InputSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
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
            return eventFirer.fire(JumpEvent(entityId: entityId))
        }

        guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(
            ofType: HoldingAxeComponent.typeId,
            for: entityId) else {
            return
        }
        eventFirer.fire(ThrowAxeEvent(entityId: holdingAxe.axeEntityID,
                                        throwerId: entityId,
                                       faceDirection: playerFacing))
    }

    func handleButtonLongPress(entityId: EntityID) {
        // TODO: charge the axe
    }
}
