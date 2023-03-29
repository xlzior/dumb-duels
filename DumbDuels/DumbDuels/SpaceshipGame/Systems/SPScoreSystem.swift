//
//  SPScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

class SPScoreSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer
    private var scores: Assemblage1<ScoreComponent>
    private var spaceships: Assemblage2<SpaceshipComponent, PhysicsComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.scores = entityManager.assemblage(requiredComponents: ScoreComponent.self)
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self, PhysicsComponent.self)
        self.eventFirer = eventFirer
    }

    func update() {

    }

    func incrementScoreFor(everyoneBut playerId: EntityID) {
        for score in scores where score.playerId != playerId {
            score.score += 1
        }
        reset()
    }

    func handleRockHitPlayer(rockId: EntityID, playerId: EntityID) {
        guard let rock: RockComponent = entityManager.getComponent(
            ofType: RockComponent.typeId, for: rockId) else {
            return
        }

        if let rockActivatedBy = rock.playerId,
           rockActivatedBy == playerId {
            // first collision doesn't count
            rock.playerId = nil
            return
        }

        incrementScoreFor(everyoneBut: playerId)
        destroySpaceship(playerId)
    }

    func handleBulletHitPlayer(bulletId: EntityID, playerId: EntityID) {
        guard let bullet: BulletComponent = entityManager.getComponent(
            ofType: BulletComponent.typeId, for: bulletId) else {
            return
        }

        if bullet.playerId == playerId {
            return
        }

        incrementScoreFor(everyoneBut: playerId)
        destroySpaceship(playerId)
    }

    func reset() {

    }

    private func destroySpaceship(_ spaceshipId: EntityID) {
        guard let (_, physicsComponent) = spaceships.getComponents(for: spaceshipId) else {
            return
        }
        // Not removed here, removed in SPRoundSystem in the same update cycle
//        physicsComponent.toBeRemoved = true
//        physicsComponent.shouldDestroyEntityWhenRemove = true
        eventFirer.fire(SpaceshipDestroyedEvent(spaceshipId: spaceshipId))
    }
}
