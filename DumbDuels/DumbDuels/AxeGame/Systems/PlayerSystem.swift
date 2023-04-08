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
    private var animateAndSoundPlayer: Assemblage3<PlayerComponent, AnimationComponent, SoundComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.cannotJumpPlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PhysicsComponent.self,
            excludedComponents: CanJumpComponent.self)
        self.animateAndSoundPlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, AnimationComponent.self, SoundComponent.self)
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
        for (entity, _, animation, sound) in animateAndSoundPlayer.entityAndComponents {
            guard entity.id == entityId else {
                continue
            }
            animation.isPlaying = true
            sound.sounds[AXSoundTypes.playerHit]?.play()
        }
    }
}
