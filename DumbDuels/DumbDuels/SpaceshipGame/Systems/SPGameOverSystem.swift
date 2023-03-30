//
//  SPGameOverSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 30/3/23.
//

import DuelKit

class SPGameOverSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer
    private var entityCreator: EntityCreator
    private var onGameOver: () -> Void

    private var spaceships: Assemblage4<SpaceshipComponent, ScoreComponent, PositionComponent, PhysicsComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer, onGameOver: @escaping () -> Void) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.entityCreator = EntityCreator(entityManager: entityManager)
        self.spaceships = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, ScoreComponent.self,
            PositionComponent.self, PhysicsComponent.self)
        self.onGameOver = onGameOver
    }

    func update() {}

    func handleGameTied() {
        entityCreator.createGameOverText(at: Positions.text, of: Sizes.gameTiedText, displaying: Assets.gameTiedText)
        onGameOver()
    }

    func handleGameWon(by entityId: EntityID) {
        for (entity, spaceship, _, _, _) in spaceships.entityAndComponents where entity.id == entityId {
            entityCreator.createGameOverText(
                at: Positions.text, of: Sizes.gameWonText, displaying: Assets.gameWonText[spaceship.index])
            onGameOver()
        }
    }
}
