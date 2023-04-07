//
//  TAInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class TAInputSystem {
    var playerIndexToIdMap = [Int: EntityID]()

    var entityManager: EntityManager
    var tanks: Assemblage3<TankComponent, RotationComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.tanks = entityManager.assemblage(requiredComponents: TankComponent.self, RotationComponent.self, PhysicsComponent.self)
    }
}

// TODO: (WJ) I don't like this, I don't think it makes sense
extension TAInputSystem: IndexMapInitializable {
    func setPlayerId(firstPlayer: EntityID, secondPlayer: EntityID) {
        playerIndexToIdMap[0] = firstPlayer
        playerIndexToIdMap[1] = secondPlayer
    }
}

extension TAInputSystem: InputSystem {
    func update() {

    }

    func handleButtonDown(playerIndex: Int) {
        guard let tankId = playerIndexToIdMap[playerIndex],
              let (_, rotation, physics) = tanks.getComponents(for: tankId) else {
            return
        }

        entityManager.remove(componentType: AutoRotateComponent.typeId, from: tankId)
        physics.velocity = TAConstants.movingSpeed * CGVector(angle: rotation.angleInRadians)
    }

    func handleButtonUp(playerIndex: Int) {
        guard let tankId = playerIndexToIdMap[playerIndex],
              let (tank, tankData, _, physics) = tanks.getEntityAndComponents(for: tankId) else {
            return
        }

        tankData.rotationDirection *= -1
        tank.assign(component: AutoRotateComponent(by: tankData.rotationDirection * TAConstants.rotationSpeed))
        physics.velocity = .zero
    }
}
