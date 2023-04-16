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
    private var stars: Assemblage1<StarComponent>
    private var previousParticleSpawnInfo: [EntityID: Pair<CGPoint, CGFloat>]
    private let numStarParticles = 40

    init(for entityManager: EntityManager, entityCreator: SPEntityCreator) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.movingSpaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self,
                                                         PositionComponent.self, RotationComponent.self,
                                                         SizeComponent.self,
                                                         excludedComponents: AutoRotateComponent.self)
        self.stars = entityManager.assemblage(requiredComponents: StarComponent.self)
        previousParticleSpawnInfo = [EntityID: Pair<CGPoint, CGFloat>]()
    }

    func update() {
        for (spaceship, _, position, rotation, size) in movingSpaceships.entityAndComponents {
            guard canCreateParticle(for: spaceship.id) else {
                return
            }

            let particlePosistion = position.position
                + (SPSizes.accelerationParticle.height / 2
                + size.actualSize.height / 2)
                * CGVector(angle: rotation.angleInRadians).reverse()
            entityCreator.createAccelerationParticle(at: particlePosistion, of: SPSizes.accelerationParticle)
        }
        while stars.count < numStarParticles {
            createNewStar()
        }
    }

    private func canCreateParticle(for spaceshipId: EntityID) -> Bool {
        guard let (_, position, _, _) = movingSpaceships.getComponents(for: spaceshipId) else {
            return false
        }
        let nextRandomFactor = CGFloat.random(in: 2...5)
        guard let prevSpawnInfo = previousParticleSpawnInfo[spaceshipId] else {
            previousParticleSpawnInfo[spaceshipId] = Pair(position.position, nextRandomFactor)
            return true
        }
        let prevPosition = prevSpawnInfo.first
        let multiplesOfParticleSize = prevSpawnInfo.second
        let minimumsSpacing = multiplesOfParticleSize
            * max(SPSizes.accelerationParticle.height, SPSizes.accelerationParticle.width)
        if position.position.distanceTo(prevPosition) > minimumsSpacing {
            previousParticleSpawnInfo[spaceshipId] = Pair(position.position, nextRandomFactor)
            return true
        }
        return false
    }

    func resetMapping() {
        previousParticleSpawnInfo.removeAll()
    }

    private func createNewStar() {
        let randomPosition = CGPoint.random(within: Sizes.game)

        entityCreator.createStarParticle(at: randomPosition, of: SPSizes.star)
    }
}
