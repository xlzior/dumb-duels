//
//  PlayerSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class PlayerSystem: System {
    unowned var entityManager: EntityManager

    private var cannotJumpPlayer: Assemblage1<PlayerComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannotJumpPlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self, excludedComponents: CanJumpComponent.self)
    }

    func update() {

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
