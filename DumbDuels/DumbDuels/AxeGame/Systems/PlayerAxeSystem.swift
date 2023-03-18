//
//  PlayerAxeSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class PlayerAxeSystem: System {

    unowned var entityManager: EntityManager
    unowned var eventManager: EventManager

    private var holdingAxePlayer: Assemblage2<PlayerComponent, HoldingAxeComponent>
    private var axe: Assemblage2<AxeComponent, PhysicsComponent>
    private var canJumpPlayer: Assemblage3<PlayerComponent, CanJumpComponent, PhysicsComponent>
    private var cannotJumpPlayer: Assemblage1<PlayerComponent>

    init(for entityManager: EntityManager, eventManager: EventManager) {
        self.entityManager = entityManager
        self.eventManager = eventManager
        self.holdingAxePlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self,
                                                         HoldingAxeComponent.self)
        self.axe = entityManager.assemblage(requiredComponents: AxeComponent.self, PhysicsComponent.self)
        self.canJumpPlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self, CanJumpComponent.self, PhysicsComponent.self)
        self.cannotJumpPlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self, excludedComponents: CanJumpComponent.self)
    }

    func update() {

    }

    func throwsAxe(axeId: EntityID, by playerId: EntityID) {
        guard entityManager.isMember(playerId, ofAssemblageWithTraits: holdingAxePlayer.traits),
              entityManager.isMember(axeId, ofAssemblageWithTraits: axe.traits),
              let physicsComponent: PhysicsComponent = entityManager.getComponent(for: axeId) else {
            assertionFailure("Throw axe failed for playerId \(playerId) and axeId \(axeId)")
            return
        }
        physicsComponent.affectedByGravity = true
        entityManager.remove(componentType: HoldingAxeComponent.typeId, from: playerId)
    }

    func jump(playerId: EntityID) {
        guard entityManager.isMember(playerId, ofAssemblageWithTraits: canJumpPlayer.traits),
              let physicsComponent: PhysicsComponent = entityManager.getComponent(for: playerId),
              let canJumpComponent: CanJumpComponent = entityManager.getComponent(for: playerId) else {
            print("Player \(playerId) cannot jump")
            return
        }
        physicsComponent.impulse += Constants.jumpForce
        canJumpComponent.jumpsLeft -= 1
        if canJumpComponent.jumpsLeft <= 0 {
            entityManager.remove(componentType: CanJumpComponent.typeId, from: playerId)
        }
    }

    func possibleLand(playerId: EntityID ) {
        guard entityManager.isMember(playerId, ofAssemblageWithTraits: cannotJumpPlayer.traits),
              let physicsComponent: PhysicsComponent = entityManager.getComponent(for: playerId),
              physicsComponent.velocity.dy <= 0 else {
            print("Player \(playerId) cannot jump")
            return
        }
        entityManager.assign(component: CanJumpComponent(), to: playerId)
        print("Player \(playerId) assigned can jump component")
    }

}
