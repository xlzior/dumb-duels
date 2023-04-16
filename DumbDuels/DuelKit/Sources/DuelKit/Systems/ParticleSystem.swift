//
//  ParticleSystem.swift
//
//
//  Created by Esmanda Wong on 10/4/23.
//

import CoreGraphics

public class ParticleSystem: InternalSystem {
    var priority: InternalSystemOrder = .particle

    unowned var entityManager: EntityManager

    var explodingParticles: Assemblage2<WillExplodeParticlesComponent, PositionComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.explodingParticles = entityManager.assemblage(
            requiredComponents: WillExplodeParticlesComponent.self, PositionComponent.self)
    }

    public func update() {}

    public func createExplodingParticles(for entityId: EntityID) {
        for (entity, explode, position) in explodingParticles.entityAndComponents {
            guard entity.id == entityId else {
                continue
            }

            for _ in 0..<explode.numExplodingParticles {
                let randomXDelta = CGFloat.random(in: explode.randomXDeltaRange)
                let randomYDelta = CGFloat.random(in: explode.randomYDeltaRange)
                let travelDistance = CGFloat.random(in: explode.travelDistanceRange)
                let velocityDirection = CGVector(dx: randomXDelta, dy: randomYDelta).normalized()
                let initialPosition = position.position + CGPoint(x: randomXDelta, y: randomYDelta)
                let deltaPosition = (velocityDirection * travelDistance).toPoint()
                let travelTime: CGFloat = 1

                createParticle(
                    at: initialPosition,
                    of: explode.particleSize,
                    sprite: explode.particles.randomElement() ?? "",
                    deltaPosition: deltaPosition,
                    travelTime: travelTime)
            }
        }
    }

    private func createParticle(at position: CGPoint, of size: CGSize, sprite: String,
                                deltaPosition: CGPoint, travelTime: CGFloat) {
        let particle = entityManager.createEntity {
            PositionComponent(position: position)
            RotationComponent()
            SizeComponent(originalSize: size)
            SpriteComponent(assetName: sprite)
        }

        let animation = AnimationComponent(
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0,
                    deltaPosition: .zero),
                AnimationFrame(
                    frameDuration: travelTime,
                    alpha: 1,
                    deltaPosition: deltaPosition),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0,
                    deltaPosition: .zero)],
            numRepeat: 0,
            shouldDestroyEntityOnEnd: true
        )
        particle.assign(component: animation)
    }
}
