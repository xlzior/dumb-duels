//
//  SPAnimationCreatorSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit
import CoreGraphics
import Foundation

class SPAnimationCreatorSystem: System {

    unowned var entityManager: EntityManager
    private var entityCreator: SPEntityCreator

    private var movingSpaceships: Assemblage4<SpaceshipComponent, PositionComponent,
                                              RotationComponent, SizeComponent>
    private var previousParticleSpawnInfo: [EntityID: Pair<CGPoint, CGFloat>]

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.entityCreator = SPEntityCreator(entityManager: entityManager)
        self.movingSpaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self,
                                                         PositionComponent.self, RotationComponent.self,
                                                         SizeComponent.self,
                                                         excludedComponents: AutoRotateComponent.self)
        previousParticleSpawnInfo = [EntityID: Pair<CGPoint, CGFloat>]()
    }

    func update() {
        for (spaceship, _, position, rotation, size) in movingSpaceships.entityAndComponents {
            guard canCreateParticle(for: spaceship.id) else {
                return
            }

            let particlePosistion = position.position + (SPSizes.accelerationParticle.height / 2
                                                         + size.actualSize.height / 2) * CGVector(angle: rotation.angleInRadians).reverse()
            entityCreator.createAccelerationParticle(at: particlePosistion, of: SPSizes.accelerationParticle)
        }
    }

    private func canCreateParticle(for spaceshipId: EntityID) -> Bool {
        guard let (_, position, _, _) = movingSpaceships.getComponents(for: spaceshipId) else {
            return false
        }
        let nextRandomFactor = CGFloat.random(in: 2...5)
        guard let prevSpawnInfo = previousParticleSpawnInfo[spaceshipId] else {
            previousParticleSpawnInfo[spaceshipId] = Pair(first: position.position, second: nextRandomFactor)
            return true
        }
        let prevPosition = prevSpawnInfo.first
        let multiplesOfParticleSize = prevSpawnInfo.second
        let minimumsSpacing = multiplesOfParticleSize * max(SPSizes.accelerationParticle.height, SPSizes.accelerationParticle.width)
        if position.position.distanceTo(prevPosition) > minimumsSpacing {
            previousParticleSpawnInfo[spaceshipId] = Pair(first: position.position, second: nextRandomFactor)
            return true
        }
        return false
    }

}
