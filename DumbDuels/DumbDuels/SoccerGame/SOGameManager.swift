//
//  SOGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class SOGameManager: GameManager {
    private var entityCreator: SOEntityCreator?

    override func setUpEntities() {
        let creator = SOEntityCreator(entityManager: entityManager)
        entityCreator = creator

        for index in 0...1 {
            let player = creator.createPlayer(
                index: index,
                at: SOPositions.players[index],
                of: SOSizes.player,
                rotation: SOPositions.playerRotations[index])
            creator.createGoal(
                attackerId: player.id,
                at: SOPositions.goals[index],
                of: SOSizes.goal,
                thickness: SOSizes.goalThickness,
                facing: SOPositions.goalFacing[index])

            initialPlayerIndexToIdMap[index] = player.id
        }

        for (position, (size, rotation)) in zip(SOPositions.walls,
                                                zip(SOSizes.walls,
                                                    SOPositions.wallRotations)) {
            creator.createWall(at: position, of: size, rotation: rotation)
        }

        creator.createBall(at: SOPositions.ball, of: SOSizes.ball)
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let ball = SOCollisions.ballBitmask
        let goal = SOCollisions.goalBackBitmask

        contactHandlers[Pair(first: ball, second: goal)] = { (_: EntityID, goal: EntityID) -> Event in
            BallHitGoalEvent(goalId: goal)
        }

        contactHandlers[Pair(first: goal, second: ball)] = { (goal: EntityID, _: EntityID) -> Event in
            BallHitGoalEvent(goalId: goal)
        }

        return contactHandlers
    }

    override func setUpUserSystems() {
        systemManager.register(SOInputSystem(for: entityManager))
        systemManager.register(SOScoreSystem(for: entityManager))
        systemManager.register(SORoundSystem(for: entityManager, eventFirer: eventManager))

        useAutoRotateSystem()
        useGameOverSystem(gameStartText: Assets.battleText,
                          gameTieText: Assets.gameTiedText,
                          gameWonTexts: Assets.gameWonText)
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }
}
