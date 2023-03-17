//
//  RenderSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

class RenderSystem: System {
    var entityManager: EntityManager
    var gameController: GameController
    var screenSize: CGSize

    init(for entityManager: EntityManager, eventManger: EventManager, gameController: GameController, screenSize: CGSize) {
        self.entityManager = entityManager
        self.gameController = gameController
        self.screenSize = screenSize
    }

    func update() {

    }
}
