//
//  SOInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

class SOInputSystem: InputSystem {
    unowned var entityManager: EntityManager
    var playerIndexToIdMap = [Int: DuelKit.EntityID]()

    private let players: Assemblage3<SoccerPlayerComponent, RotationComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.players = entityManager.assemblage(
            requiredComponents: SoccerPlayerComponent.self, RotationComponent.self, PhysicsComponent.self)
    }

    func handleButtonDown(playerIndex: Int) {
        guard let playerId = playerIndexToIdMap[playerIndex],
              let (player, rotation, physics) = players.getComponents(for: playerId) else {
            return
        }

        player.isMoving = true
        entityManager.remove(componentType: AutoRotateComponent.typeId, from: playerId)
        physics.velocity = SOConstants.movingSpeed * CGVector(angle: rotation.angleInRadians)
    }

    func handleButtonUp(playerIndex: Int) {
        guard let playerId = playerIndexToIdMap[playerIndex],
              let (player, playerData, _, physics) = players.getEntityAndComponents(for: playerId) else {
            return
        }

        playerData.isMoving = false
        player.assign(component: AutoRotateComponent(by: SOConstants.rotationSpeed))
        physics.velocity = .zero
    }

    func update() {
        for (player, rotation, physics) in players {
            physics.velocity = player.isMoving
                ? SOConstants.movingSpeed * CGVector(angle: rotation.angleInRadians)
                : .zero
        }
    }
}
