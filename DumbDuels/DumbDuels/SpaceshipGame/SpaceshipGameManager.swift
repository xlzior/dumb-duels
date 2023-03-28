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

            // TODO: testing gun component and bullets
            // the gun already works, but there are no gun powerups being spawned
//            spaceship.assign(component: GunComponent())

            renderSystemDetails.gameController.registerPlayerID(playerIndex: index, playerEntityID: spaceship.id)
        }
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let spaceship = SpaceshipCollisions.spaceshipBitmask
        let rock = SpaceshipCollisions.rockBitmask
        let bullet = SpaceshipCollisions.bulletBitmask
        let powerup = SpaceshipCollisions.powerupBitmask

        contactHandlers[Pair(first: spaceship, second: rock)] = { (spaceship: EntityID, rock: EntityID) -> Event in
            RockHitPlayerEvent(rockId: rock, playerId: spaceship)
        }

        contactHandlers[Pair(first: rock, second: spaceship)] = { (rock: EntityID, spaceship: EntityID) -> Event in
            RockHitPlayerEvent(rockId: rock, playerId: spaceship)
        }

        contactHandlers[Pair(first: spaceship, second: bullet)] = { (spaceship: EntityID, bullet: EntityID) -> Event in
            BulletHitPlayerEvent(bulletId: bullet, playerId: spaceship)
        }

        contactHandlers[Pair(first: bullet, second: spaceship)] = { (bullet: EntityID, spaceship: EntityID) -> Event in
            BulletHitPlayerEvent(bulletId: bullet, playerId: spaceship)
        }

        contactHandlers[Pair(first: spaceship, second: powerup)] = { (spaceship: EntityID, powerup: EntityID) -> Event in
            PlayerHitPowerupEvent(powerupId: powerup, playerId: spaceship)
        }

        contactHandlers[Pair(first: powerup, second: spaceship)] = { (powerup: EntityID, spaceship: EntityID) -> Event in
            PlayerHitPowerupEvent(powerupId: powerup, playerId: spaceship)
        }

        return contactHandlers
    }

    override func setUpSystems() {
        systemManager.register(SpaceshipGameInputSystem(for: entityManager))
        systemManager.register(BulletAgeSystem(for: entityManager))
        systemManager.register(GunSystem(for: entityManager))
        systemManager.register(RotationSystem(for: entityManager))
        systemManager.register(WraparoundSystem(for: entityManager))
        systemManager.register(SpaceshipScoreSystem(for: entityManager))
        systemManager.register(PowerupSystem(for: entityManager))
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
