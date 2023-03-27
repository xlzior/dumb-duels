//
//  RotationSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import DuelKit

class RotationSystem: System {
    unowned var entityManager: EntityManager
    private var spaceships: Assemblage2<SpaceshipComponent, RotationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self, RotationComponent.self)
    }

    func update() {
        for (_, rotation) in spaceships {
            rotation.angleInRadians = (rotation.angleInRadians + SpaceshipConstants.rotationSpeed)
                .truncatingRemainder(dividingBy: 2 * Double.pi)
        }
    }
}
