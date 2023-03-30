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

    private var spaceships: Assemblage4<SpaceshipComponent, ScoreComponent, PositionComponent, PhysicsComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.entityCreator = EntityCreator(entityManager: entityManager)
        self.spaceships = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, ScoreComponent.self,
            PositionComponent.self, PhysicsComponent.self)
    }

    func update() {}

    func handleGameTied() {
        entityCreator.createGameOverText(at: Positions.text, of: Sizes.gameTiedText, displaying: Assets.gameTiedText)
    }

    func handleGameWon(by entityId: EntityID) {
        for (entity, spaceship, _, _, _) in spaceships.entityAndComponents {
            guard entity.id == entityId else {
                continue
            }
            entityCreator.createGameOverText(
                at: Positions.text, of: Sizes.gameWonText, displaying: Assets.gameWonText[spaceship.index])
        }
    }
}
