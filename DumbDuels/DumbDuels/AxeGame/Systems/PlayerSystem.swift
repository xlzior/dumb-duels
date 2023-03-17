//
//  PlayerSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class PlayerSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventManager: EventManager

    init(for entityManager: EntityManager, eventManager: EventManager) {
        self.entityManager = entityManager
        self.eventManager = eventManager
    }

    func update() {

    }

    func handleButtonPress(entityId: EntityID) {
        let hasAxe = entityManager.has(componentTypeId: HoldingAxeComponent.typeId, entityId: entityId)

        // TODO: also add the condition that player is not already jumping
        if !hasAxe {
            handleJump(playerId: entityId)
            return eventManager.fire(JumpEvent(entityId: entityId))
        }

        guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(
            ofType: HoldingAxeComponent.typeId,
            for: entityId) else {
            return
        }
        eventManager.fire(ThrowAxeEvent(entityId: holdingAxe.axeEntityID))
    }

    func handleJump(playerId: EntityID) {
        // TODO: This function does not apply jump impulse to SpriteKit, rather it marks the player as
        // TODO: jumping so that the player does not jump again upon spam input
        // TODO: This is called inside handleButtonPress, after we know the player is going to jump.
    }

    func handleLand(playerId: EntityID) {
        // TODO: Similar to handleJump, but the reverse
        // TODO: This is called by LandEvent
    }
}
