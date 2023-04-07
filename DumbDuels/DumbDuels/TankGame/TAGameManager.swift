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
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        let contactHandlers = PhysicsSystem.ContactHandlerMap()
        return contactHandlers
    }

    override func setUpUserSystems() {
        systemManager.register(TAInputSystem(for: entityManager))

        useAutoRotateSystem()
        useGameOverSystem(gameStartText: Assets.battleText,
                          gameTieText: Assets.gameTiedText,
                          gameWonTexts: Assets.gameWonText)
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }
}
