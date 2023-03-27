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
            let position = CGPoint.random(within: Sizes.game)
            // TODO: make sure the ships don't already collide
            let spaceship = entityCreator.createSpaceship(index: index, at: position, of: SpaceshipSizes.spaceship)

            // TODO: testing bullet
            let position2 = CGPoint.random(within: Sizes.game)
            let direction = CGFloat.random(in: -Double.pi...Double.pi)
            _ = entityCreator.createBullet(index: index, from: spaceship.id, direction: direction, at: position2, of: SpaceshipSizes.bullet)

            renderSystemDetails.gameController.registerPlayerID(playerIndex: index, playerEntityID: spaceship.id)
        }

        // TODO: testing rock
        let position = CGPoint.random(within: Sizes.game)
        let direction = CGFloat.random(in: -Double.pi...Double.pi)
        _ = entityCreator.createRock(at: position, of: SpaceshipSizes.rock, direction: direction)
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let spaceship = SpaceshipCollisions.spaceshipBitmask
        let rock = SpaceshipCollisions.rockBitmask
        let bullet = SpaceshipCollisions.bulletBitmask

        contactHandlers[Pair(first: spaceship, second: rock)] = { (spaceship: EntityID, _: EntityID) -> Event in
            RockHitPlayerEvent(playerId: spaceship)
        }

        contactHandlers[Pair(first: rock, second: spaceship)] = { (_: EntityID, spaceship: EntityID) -> Event in
            RockHitPlayerEvent(playerId: spaceship)
        }

        contactHandlers[Pair(first: spaceship, second: bullet)] = { (spaceship: EntityID, bullet: EntityID) -> Event in
            BulletHitPlayerEvent(bulletId: bullet, playerId: spaceship)
        }

        contactHandlers[Pair(first: bullet, second: spaceship)] = { (bullet: EntityID, spaceship: EntityID) -> Event in
            BulletHitPlayerEvent(bulletId: bullet, playerId: spaceship)
        }

        return contactHandlers
    }

    override func setUpSystems() {
        systemManager.register(SpaceshipGameInputSystem(for: entityManager))
        systemManager.register(RotationSystem(for: entityManager))
        systemManager.register(WraparoundSystem(for: entityManager))
        systemManager.register(PhysicsSystem(
            for: entityManager, eventFirer: eventManager,
            scene: simulator.gameScene, contactHandlers: getContactHandlers()))
        systemManager.register(RenderSystem(
            for: entityManager,
            eventManger: eventManager,
            details: renderSystemDetails
        ))
    }
}
