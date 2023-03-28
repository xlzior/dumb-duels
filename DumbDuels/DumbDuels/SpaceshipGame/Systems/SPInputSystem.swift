//
//  SPInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPInputSystem: InputSystem {
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

        // TODO: angle convention for cgvector is not the same as rotation component conventions
        // TODO: change CGVector+Extensions?
        let angle = CGVector(angle: Double.pi / 2 - rotation.angleInRadians)
        physics.impulse = SPConstants.propulsionForce * angle

        entityManager.remove(componentType: AutoRotateComponent.typeId, from: entityId)

        DispatchQueue.main.asyncAfter(deadline: .now() + SPConstants.rotationStoppedInternval) {
            self.entityManager.assign(component: AutoRotateComponent(), to: entityId)
        }
    }

    func handleButtonUp(entityId: EntityID) {

    }

    func update() {

    }
}
