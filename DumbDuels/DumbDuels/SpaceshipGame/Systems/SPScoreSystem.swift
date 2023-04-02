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
    private var isHitThisFrame: Set<EntityID>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.scores = entityManager.assemblage(requiredComponents: ScoreComponent.self)
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self, PhysicsComponent.self)
        self.eventFirer = eventFirer
        self.isHitThisFrame = []
    }

    func update() {
        isHitThisFrame.removeAll()
    }

    func incrementScoreFor(everyoneBut playerId: EntityID) {
        for score in scores where score.playerId != playerId {
            score.score += 1
        }
    }

    func handleRockHitPlayer(rockId: EntityID, playerId: EntityID) {
        guard let rock: RockComponent = entityManager.getComponent(
            ofType: RockComponent.typeId, for: rockId) else {
            return
        }

        guard !isHitThisFrame.contains(playerId) else {
            return
        }
        isHitThisFrame.insert(playerId)
        incrementScoreFor(everyoneBut: playerId)
        destroySpaceship(playerId)
    }

    func handleBulletHitPlayer(bulletId: EntityID, playerId: EntityID) {
        guard let bullet: BulletComponent = entityManager.getComponent(
            ofType: BulletComponent.typeId, for: bulletId) else {
            return
        }

        guard bullet.playerId != playerId,
              !isHitThisFrame.contains(playerId) else {
            return
        }
        isHitThisFrame.insert(playerId)
        incrementScoreFor(everyoneBut: playerId)
        destroySpaceship(playerId)
    }

    private func destroySpaceship(_ spaceshipId: EntityID) {
        guard spaceships.isMember(entityId: spaceshipId) else {
            return
        }
        // Not removed here, removed in SPRoundSystem in the same update cycle
//        physicsComponent.toBeRemoved = true
//        physicsComponent.shouldDestroyEntityWhenRemove = true
        eventFirer.fire(SpaceshipDestroyedEvent(spaceshipId: spaceshipId))
    }
}
