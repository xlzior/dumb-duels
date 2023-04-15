//
//  TTScoreSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit
import Foundation

class TTScoreSystem: System {

    var entityManager: EntityManager

    private let eventFirer: EventFirer

    private let scorelines: Assemblage2<ScoreLineComponent, PositionComponent>
    private let players: Assemblage2<TTPlayerComponent, ScoreComponent>
    private let landedBlocks: Assemblage5<BlockComponent, PhysicsComponent, PositionComponent,
                                            RotationComponent, SizeComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.scorelines = entityManager.assemblage(requiredComponents: ScoreLineComponent.self,
                                                   PositionComponent.self)
        self.players = entityManager.assemblage(requiredComponents: TTPlayerComponent.self, ScoreComponent.self)
        self.landedBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self,
                                                     PhysicsComponent.self, PositionComponent.self,
                                                     RotationComponent.self, SizeComponent.self,
                                                     excludedComponents: HasGuidelineComponent.self)
        self.eventFirer = eventFirer
    }

    func update() {
        // get highest position for each player
        let highestPositionMap = getHighestPositionForEachPlayer()
        for (scorelineEntity, scoreline, scorelinePosition) in scorelines.entityAndComponents {
            guard let playerHighestPoint = highestPositionMap[scoreline.playerId],
                  let (_, score) = players.getComponents(for: scoreline.playerId) else {
                continue
            }

            if playerHighestPoint >= scorelinePosition.position.y {
                score.score += 1
                print("highest point is \(playerHighestPoint) socreline position is \(scorelinePosition.position.y)")
                print("Score for \(scoreline.playerId) is now \(score.score)")
                entityManager.destroy(entityId: scorelineEntity.id)
            }
            if score.score >= TTConstants.winningScore {
                eventFirer.fire(TTGameOverEvent())
            }
        }
    }

    private func getHighestPositionForEachPlayer() -> [EntityID: CGFloat] {
        var highestPositionMap = [EntityID: CGFloat]()

        for (block, physics, position, rotation, size) in landedBlocks where physics.velocity == .zero {
            let playerId = block.playerId
            let theta = rotation.angleInRadians.truncatingRemainder(dividingBy: 2 * Double.pi)
            let blockSpanningHeight: CGFloat = size.actualSize.width * abs(sin(theta))
                                               + size.actualSize.height * abs(cos(theta))
            let blockHighestPoint = position.position.y + blockSpanningHeight / 2

            guard let currentHighestForThisPlayer = highestPositionMap[playerId] else {
                highestPositionMap[playerId] = blockHighestPoint
                continue
            }

            if blockHighestPoint > currentHighestForThisPlayer {
                highestPositionMap[playerId] = blockHighestPoint
            }
        }

        return highestPositionMap
    }
}
