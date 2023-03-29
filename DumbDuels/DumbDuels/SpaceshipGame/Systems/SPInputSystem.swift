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

        let angle = CGVector(angle: rotation.angleInRadians)
        // set the velocity directly so there is no drifting
        physics.velocity = SPConstants.propulsionForce * angle
        physics.linearDamping = SPPhysics.spaceshipMovingDamping

        entityManager.remove(componentType: AutoRotateComponent.typeId, from: entityId)

        DispatchQueue.main.asyncAfter(deadline: .now() + SPConstants.rotationStoppedInterval) {
            guard self.canAssignAutoRotate(entityId: entityId) else {
                return
            }
            self.entityManager.assign(component: AutoRotateComponent(), to: entityId)
            physics.linearDamping = SPPhysics.spaceshipStaticDamping
        }
    }

    func handleButtonUp(entityId: EntityID) {

    }

    func update() {

    }

    private func canAssignAutoRotate(entityId: EntityID) -> Bool {
        spaceships.isMember(entityId: entityId) &&
        !entityManager.has(componentTypeId: AutoRotateComponent.typeId, entityId: entityId)
    }
}
