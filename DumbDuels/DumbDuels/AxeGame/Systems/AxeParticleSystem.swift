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
    private var thrownAxe: Assemblage4<AxeComponent, PositionComponent, RotationComponent, PhysicsComponent>
    private var axeParicle: Assemblage2<AxeParticleComponent, PhysicsComponent>
    let particleRadius: Double = 5.0

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.thrownAxe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self)
        self.axeParicle = entityManager.assemblage(requiredComponents: AxeParticleComponent.self, PhysicsComponent.self)
    }

    func update() {
        for (_, axeParticleComponent, physicsComponent) in axeParicle.entityAndComponents {
            let currentTime = Date()
            if currentTime > axeParticleComponent.destroyTime {
                physicsComponent.toBeRemoved = true
                physicsComponent.shouldDestroyEntityWhenRemove = true
            }
        }
    }

    func createParticlesFrom(axeEntityId: EntityID) {
        guard let (_, axePosition, _, physicsComponent) = thrownAxe.getComponents(for: axeEntityId) else {
            assertionFailure("Trying to create particles from a non-axe entity \(axeEntityId)")
            return
        }
        // Destroy the axe
        physicsComponent.toBeRemoved = true
        physicsComponent.shouldDestroyEntityWhenRemove = true

        // Create axe particles
        let creationTime = Date()
        for i in 0...4 {
            let angle = Double.pi / 4 + i * Double.pi / 8
            for j in 1...3 {
                let relativeDistance = 2 * j * particleRadius
                let yPosition = sin(angle) * relativeDistance
                let xPosition = cos(angle) * relativeDistance
                let particleRelativePosition = CGPoint(x: xPosition, y: yPosition)
                createAxeParticle(at: particleRelativePosition, relativeTo: axePosition.position,
                                  creationTime: creationTime)
            }
        }
    }

    private func createAxeParticle(at position: CGPoint, relativeTo axePosition: CGPoint,
                                   creationTime: Date) {
        let entityCreator = EntityCreator(entityManager: entityManager)
        let particlePosition = position + axePosition
        let particleSize = CGSize(width: particleRadius * 2, height: particleRadius * 2)
        let particleVelocity = 120.0 * position.length() / 20
                               * position.toVector().normalized()
        entityCreator.createAxeParticle(at: particlePosition, of: particleSize,
                                        velocity: particleVelocity, createdTime: creationTime)

    }

}
