//
//  TAGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class TAGameManager: GameManager {
    private var entityCreator: TAEntityCreator?

    override func setUpEntities() {
        let creator = TAEntityCreator(entityManager: entityManager)
        entityCreator = creator

        for index in 0...1 {
            let tank = creator.createTank(index: index, at: TAPositions.tanks[index], of: TASizes.tank)

            initialPlayerIndexToIdMap[index] = tank.id
        }

        for (position, size) in zip(TAPositions.walls, TASizes.walls) {
            creator.createWall(at: position, of: size)
        }

        for (position, size) in zip(TAPositions.sideWalls, TASizes.sideWalls) {
            creator.createSideWall(at: position, of: size)
        }
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        let contactHandlers = PhysicsSystem.ContactHandlerMap()
        return contactHandlers
    }

    override func setUpUserSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(TAInputSystem(for: entityManager, entityCreator: creator))

        useAutoRotateSystem()
        useGameOverSystem(gameStartText: Assets.battleText,
                          gameTieText: Assets.gameTiedText,
                          gameWonTexts: Assets.gameWonText)
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }
}
