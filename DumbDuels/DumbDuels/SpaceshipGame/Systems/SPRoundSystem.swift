//
//  SPRoundSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import DuelKit
import CoreGraphics

class SPRoundSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer
    unowned var entityCreator: SPEntityCreator

    private var spaceships: Assemblage5<SpaceshipComponent, PhysicsComponent,
                                        PositionComponent, SizeComponent, RotationComponent>
    private var isResetThisFrame: Bool

    init(for entityManager: EntityManager, eventFirer: EventFirer, entityCreator: SPEntityCreator) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.entityCreator = entityCreator
        self.spaceships = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, PhysicsComponent.self,
            PositionComponent.self, SizeComponent.self, RotationComponent.self)
        self.isResetThisFrame = false
    }

    func update() {
        isResetThisFrame = false
    }

    func reset() {
        if isResetThisFrame {
            return
        }
        isResetThisFrame = true

        let (firstPosition, secondPosition) = SPSizes.randomSpaceshipPositions()

        // edge cases: while creating, there is player input in the same cycle, check input system logic

        for (spaceship, spaceshipComponent, _, position, size, rotation)
                in spaceships.entityAndComponents {
            // Reset transform (position, size, rotation)
            let newPosition = spaceshipComponent.index == 0 ? firstPosition : secondPosition
            position.position = newPosition
            size.originalSize = SPSizes.spaceship
            size.xScale = 1.0
            size.yScale = 1.0
            rotation.angleInRadians = 0

            // reset any possible change in velocity, damping constants etc. as a result of input
            spaceship.remove(componentType: PhysicsComponent.typeId)
            let newPhysics = entityCreator.physicsCreator.createSpaceship(of: SPSizes.spaceship)
            spaceship.assign(component: newPhysics)

            // reset any powerups possibly obtained
            spaceship.remove(componentType: GunComponent.typeId)

            // reset any changes in specaship due to input
            // e.g. if it is destroyed while moving, we need to add back it's AutoRotate component
            if !entityManager.has(componentTypeId: AutoRotateComponent.typeId, entityId: spaceship.id) {
                spaceship.assign(component: AutoRotateComponent(by: SPConstants.rotationSpeed))
            }
        }

        eventFirer.fire(GameStartEvent())
    }
}
