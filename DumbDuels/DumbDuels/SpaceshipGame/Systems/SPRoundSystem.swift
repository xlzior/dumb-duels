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

    private var spaceships: Assemblage3<SpaceshipComponent, PhysicsComponent, ScoreComponent>
    private var isGameOver: Bool
    private var isResetThisFrame: Bool

    init(for entityManager: EntityManager, eventFirer: EventFirer, entityCreator: SPEntityCreator) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.entityCreator = entityCreator
        self.spaceships = entityManager.assemblage(
            requiredComponents: SpaceshipComponent.self, PhysicsComponent.self, ScoreComponent.self)
        self.isGameOver = false
        self.isResetThisFrame = false
    }

    func update() {
        isResetThisFrame = false
    }

    func checkWin() {
        var winningEntities = [EntityID]()
        for (entity, _, _, score) in spaceships.entityAndComponents
        where score.score >= SPConstants.winningScore {
            winningEntities.append(entity.id)
        }

        guard !winningEntities.isEmpty else {
            return
        }

        if winningEntities.count > 1 {
            eventFirer.fire(GameTieEvent())
        } else {
            eventFirer.fire(GameWonEvent(entityId: winningEntities[0]))
        }
        isGameOver = true
    }

    func reset() {
        if isResetThisFrame {
            return
        }

        isResetThisFrame = true

        checkWin()

        var indexToIdMap = [Int: EntityID]()
        let (firstPosition, secondPosition) = SPSizes.getSpaceshipResetPositions()

        // Should have 2 spaceships at this point because it is not destroyed before physics update
        for (spaceshipComponent, physics, oldScore) in spaceships {
            // destroy the spaceship later durign physics update
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true

            // create new spaceship
            // The new spaceship will not be iterated in this loop because the iterator is fixed at the
            // beginning of loop. Therefore we do not need to worry about deletion
            let position = spaceshipComponent.index == 0 ? firstPosition : secondPosition
            let spaceship = entityCreator.createSpaceship(index: spaceshipComponent.index,
                                                          at: position, of: SPSizes.spaceship,
                                                          score: oldScore.score)
            indexToIdMap[spaceshipComponent.index] = spaceship.id
        }

        guard let firstId = indexToIdMap[0], let secondId = indexToIdMap[1] else {
            assertionFailure("Spaceship not created properly on round reset")
            return
        }
        eventFirer.fire(SpaceshipRecreatedEvent(firstSpaceshipId: firstId, secondSpaceshipId: secondId))

        if !isGameOver {
            eventFirer.fire(GameStartEvent())
        }
    }
}
