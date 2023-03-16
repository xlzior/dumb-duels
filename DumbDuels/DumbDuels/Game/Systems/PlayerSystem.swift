//
//  PlayerSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class PlayerSystem: System {
    var entityManager: EntityManager
    var eventManger: EventManager

    init(for entityManager: EntityManager, eventManger: EventManager) {
        self.entityManager = entityManager
        self.eventManger = eventManger
    }

    func update() {

    }

    func handleButtonPress(entityId: EntityID) {
        if entityManager.has(componentTypeId: HoldingAxeComponent.Type, entityId: entityId) {
            entityManager.remove(componentType: HoldingAxeComponent.Type, from: entityId)
            let axe = entityManager.getComponent(ofType: HoldingAxeComponent.Type, for: entityId)
            eventManger.fire(ThrowAxeEvent(entityId: axe))
        } else {
            eventManger.fire(JumpEvent(entityId: entityId))
        }
    }
}
