//
//  SpaceshipGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SpaceshipGameManager: GameManager {
    override func setUpEntities() {
        let entityCreator = SpaceshipEntityCreator(entityManager: entityManager)

        for index in 0...1 {
            let position = CGPoint.random(maxX: Sizes.game.width, maxY: Sizes.game.height)
            // TODO: make sure the ships don't already collide
            let spaceship = entityCreator.createSpaceship(index: index, at: position, of: SpaceshipSizes.spaceship)

            renderSystemDetails.gameController.registerPlayerID(playerIndex: index, playerEntityID: spaceship.id)
        }
    }

    override func setUpSystems() {
        systemManager.register(SpaceshipGameInputSystem(for: entityManager))
        systemManager.register(RotationSystem(for: entityManager))
        systemManager.register(WraparoundSystem(for: entityManager))
        systemManager.register(PhysicsSystem(for: entityManager, eventFirer: eventManager,
                                             scene: simulator.gameScene, contactHandlers: [:]))
        systemManager.register(RenderSystem(
            for: entityManager,
            eventManger: eventManager,
            details: renderSystemDetails
        ))
    }
}
