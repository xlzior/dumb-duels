//
//  AxeParticleSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 27/3/23.
//

import Foundation
import DuelKit

class AxeParticleSystem: System {
    unowned var entityManager: EntityManager
    unowned var entityCreator: AXEntityCreator

    private var thrownAxe: Assemblage5<
        AxeComponent, PositionComponent, RotationComponent, PhysicsComponent, SoundComponent>
    let numParticles: Int = 20

    init(for entityManager: EntityManager, entityCreator: AXEntityCreator) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.thrownAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self, SoundComponent.self)
    }

    func update() {}

    func createParticlesFrom(axeEntityId: EntityID) {
        guard let (_, axePosition, _, physicsComponent, sound) = thrownAxe.getComponents(for: axeEntityId) else {
            assertionFailure("Trying to create particles from a non-axe entity \(axeEntityId)")
            return
        }
        // Play axe explode sound
        sound.sounds[AXSounds.axeExplode]?.isPlaying = true

        // Destroy the axe
        physicsComponent.toBeRemoved = true
        physicsComponent.shouldDestroyEntityWhenRemove = true

        // Create axe particles
        for _ in 0...numParticles {
            let randomXDelta = CGFloat.random(in: -150...150)
            let randomYDelta = CGFloat.random(in: 0...400)
            let particleImpulse = CGVector(dx: randomXDelta, dy: randomYDelta)

            var sprite: String
            let randomNumber = Int.random(in: 0...10)
            if randomNumber < 4 {
                sprite = AXAssets.axeParticleBrown
            } else {
                sprite = AXAssets.axeParticleGrey
            }
            entityCreator.createAxeParticle(
                at: axePosition.position,
                of: AXSizes.particle,
                sprite: sprite,
                impulse: particleImpulse)
        }
    }
}
