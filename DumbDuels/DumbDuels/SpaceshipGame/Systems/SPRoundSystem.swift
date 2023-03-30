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
    // TODO: Settle this passing of entity creator, axe game uses unowned and passes in constructor
    private var entityCreator: SPEntityCreator

    private var spaceships: Assemblage3<SpaceshipComponent, PhysicsComponent, ScoreComponent>
    private var isGameOver: Bool
    private var isResetThisFrame: Bool

    init(for entityManager: EntityManager,
         eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.entityCreator = SPEntityCreator(entityManager: entityManager)
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self, PhysicsComponent.self, ScoreComponent.self)
        self.isGameOver = false
        self.isResetThisFrame = false
    }

    func update() {
        isResetThisFrame = false
    }

    func checkWin() {
        var winningEntities = [EntityID]()
        for (entity, _, _, score) in spaceships.entityAndComponents where score.score >= 1 {
            winningEntities.append(entity.id)
        }

        guard !winningEntities.isEmpty else {
            return
        }

        if winningEntities.count > 1 {
            eventFirer.fire(SPGameTieEvent())
        } else {
            eventFirer.fire(SPGameWonEvent(entityId: winningEntities[0]))
        }
        isGameOver = true
    }

    func reset() {
        // TODO: not the root cause
        if isResetThisFrame {
            return
        }

        isResetThisFrame = true

        checkWin()

        var indexToIdMap = [Int: EntityID]()
        // Should have 2 spaceships at this point because it is not destroyed before physics update
        for (spaceshipComponent, physics, oldScore) in spaceships {
            // destroy the spaceship later durign physics update
            physics.toBeRemoved = true
            physics.shouldDestroyEntityWhenRemove = true

            // create new spaceship
            let position = CGPoint.random(within: Sizes.game)
            // TODO: make sure the ships don't already collide
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

        // Create Battle animation
        if !isGameOver {
            // Bing Sen TODO: Currently using Axe game's Positions, can extract common
            // stuff from EntityCreator, AnimationCreator, PhysicsCreator into DuelKit
            // and some common constants (e.g. Canvas position) into DuelKit as well
            entityCreator.createBattleText(at: Positions.text, of: Sizes.battleText)
        }
    }
}
