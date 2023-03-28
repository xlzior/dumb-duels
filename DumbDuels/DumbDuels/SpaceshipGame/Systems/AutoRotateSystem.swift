//
//  AutoRotateSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import DuelKit

class AutoRotateSystem: System {
    unowned var entityManager: EntityManager
    private var spaceships: Assemblage3<SpaceshipComponent, RotationComponent, AutoRotateComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self, RotationComponent.self, AutoRotateComponent.self)
    }

    func update() {
        for (_, rotation, _) in spaceships {
            rotation.angleInRadians = (rotation.angleInRadians + SpaceshipConstants.rotationSpeed)
                .truncatingRemainder(dividingBy: 2 * Double.pi)
        }
    }
}
