//
//  TTScoreSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import DuelKit

class TTScoreSystem: System {

    var entityManager: EntityManager

    private let scorelines: Assemblage2<ScoreLineComponent, PhysicsComponent>
    private let players: Assemblage2<TTPlayerComponent, ScoreComponent>
    private let landedBlocks: Assemblage2<BlockComponent, PhysicsComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.scorelines = entityManager.assemblage(requiredComponents: ScoreLineComponent.self, PhysicsComponent.self)
        self.players = entityManager.assemblage(requiredComponents: TTPlayerComponent.self, ScoreComponent.self)
        self.landedBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self,
                                                     PhysicsComponent.self,
                                                     excludedComponents: HasGuidelineComponent.self)
    }

    func update() {}

    func handleBlockContactScoreline(landedBlockId: EntityID, scorelineId: EntityID) {
        print("Handle contact landed Block \(landedBlockId), scorelineId: \(scorelineId)")
        guard let (block, _) = landedBlocks.getComponents(for: landedBlockId),
              let (player, score) = players.getComponents(for: block.playerId),
              let (scoreline, scorelinePhysics) = scorelines.getComponents(for: scorelineId) else {
            return
        }

        // Possible for multiple blocks to touch the same scoreline in the same frame
        // But the scoreline entity is not deleted immediately (delayed until physics update)
        // Therefore we to use `canIncreaseScore` to prevent repeated actions
        if scoreline.canIncreaseScore {
            print("score increased for player index: \(player.index)")
            scoreline.canIncreaseScore = false

            // increase score
            score.score += 1

            // destroy scoreline
            scorelinePhysics.toBeRemoved = true
            scorelinePhysics.shouldDestroyEntityWhenRemove = true
        } else {
            print("score cannot increase")
        }
    }
}
