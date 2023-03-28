//
//  PlayerSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation
import DuelKit

class PlayerSystem: System {
    unowned var entityManager: EntityManager

    private var cannotJumpPlayer: Assemblage2<PlayerComponent, PhysicsComponent>
    private var animatePlayer: Assemblage2<PlayerComponent, AnimationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannotJumpPlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PhysicsComponent.self,
            excludedComponents: CanJumpComponent.self)
        self.animatePlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, AnimationComponent.self)
    }

    func update() {

    }

    func possibleLand(playerId: EntityID ) {
        guard let (_, physics) = cannotJumpPlayer.getComponents(for: playerId),
              physics.velocity.dy <= 0 else {
            return
        }
        entityManager.assign(component: CanJumpComponent(), to: playerId)
    }

    func handleAxeHitPlayer(withEntityId entityId: EntityID) {
        for (entity, _, animation) in animatePlayer.entityAndComponents {
            guard entity.id == entityId else {
                continue
            }
            animation.isPlaying = true
        }
    }
}
