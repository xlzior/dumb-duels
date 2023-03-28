//
//  SpaceshipScoreSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

class SpaceshipScoreSystem: System {
    unowned var entityManager: EntityManager
    private var scores: Assemblage1<ScoreComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.scores = entityManager.assemblage(requiredComponents: ScoreComponent.self)
    }

    func update() {

    }

    func incrementScoreFor(everyoneBut playerId: EntityID) {
        for score in scores where score.playerId != playerId {
            score.score += 1
        }
        reset()
    }

    func handleRockHitPlayer(playerId: EntityID) {
        incrementScoreFor(everyoneBut: playerId)
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
    }

    func reset() {

    }
}
