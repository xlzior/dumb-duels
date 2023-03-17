//
//  GameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

class GameManager {
    private let gameController: GameController
    private let screenSize: CGSize

    private let entityManager: EntityManager
    private let entityCreator: EntityCreator

    private let systemManager: SystemManager
    private let eventManager: EventManager

    init(gameController: GameController, screenSize: CGSize) {
        self.gameController = gameController
        self.screenSize = screenSize

        let entityManager = EntityManager()
        let entityCreator = EntityCreator(entityManager: entityManager)
        self.entityManager = entityManager
        self.entityCreator = entityCreator

        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)
        self.systemManager = systemManager
        self.eventManager = eventManager

        setUpEntities()
        setUpSystems()
        startGame()
    }

    private func setUpEntities() {
        for playerIndex in 0...1 {
            let platform = entityCreator.createPlatform(at: Positions.platforms[playerIndex], of: Sizes.platform)
            let axe = entityCreator.createAxe(at: Positions.axes[playerIndex], of: Sizes.axe)
            let player = entityCreator.createPlayer(
                at: Positions.players[playerIndex],
                of: Sizes.player,
                holding: axe.id
            )
            gameController.registerPlayerID(playerIndex: playerIndex, playerEntityID: player.id)
        }
    }

    private func setUpSystems() {
        systemManager.register(PlayerSystem(for: entityManager, eventManger: eventManager))
        systemManager.register(RenderSystem(
            for: entityManager,
            eventManger: eventManager,
            gameController: gameController,
            screenSize: screenSize
        ))
    }

    private func updateSystems() {
        // update everything one by one
    }

    private func startGame() {
        guard let renderSystem: RenderSystem = systemManager.get() else {
            return
        }
        renderSystem.update()
    }
}

// MARK: - Handle Input
extension GameManager {
    func handleButtonPress(for entityID: EntityID) {
        eventManager.fire(ButtonPressEvent(entityId: entityID))
    }

    func handleButtonLongPress(for entityID: EntityID) {

    }
}
