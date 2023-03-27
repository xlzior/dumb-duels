//
//  SpaceshipGameInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SpaceshipGameInputSystem: InputSystem {
    unowned var entityManager: EntityManager
    private var spaceships: Assemblage3<SpaceshipComponent, RotationComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.spaceships = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, RotationComponent.self, PhysicsComponent.self)
    }

    func handleButtonDown(entityId: EntityID) {
        guard let (_, rotation, physics) = spaceships.getComponents(for: entityId) else {
            return
        }

        let angle = CGVector(angle: Double.pi / 2 - rotation.angleInRadians)
        physics.impulse = SpaceshipConstants.propulsionForce * angle
    }

    func handleButtonUp(entityId: EntityID) {

    }

    func update() {

    }
}
