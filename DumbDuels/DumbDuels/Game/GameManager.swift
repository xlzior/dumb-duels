//
//  GameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import Foundation

class GameManager {
    private let gameController: ViewController

    private let entityManager: EntityManager
    private let entityCreator: EntityCreator

    private let systemManager: SystemManager
    private let eventManager: EventManager

    init(gameController: ViewController) {
        self.gameController = gameController

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

    }

    private func setUpSystems() {
        systemManager.register(PlayerSystem(for: entityManager, eventManger: eventManager))
    }

    private func updateSystems() {
        // update everything one by one
    }

    private func startGame() {

    }
}
