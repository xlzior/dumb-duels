//
//  SPGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPGameManager: GameManager {
    override func setUpEntities() {
        let entityCreator = SPEntityCreator(entityManager: entityManager)

        for index in 0...1 {
            // TODO: Why is Sizes (from axe game) used here? Should this be extracted to game framework?
            // WJ's reply: due to some slightly questionable decisions, Sizes comes from DuelKit
            // AxeGame extends Sizes with its own stuff
            // refactor later
            let position = CGPoint.random(within: Sizes.game)
            // TODO: make sure the ships don't already collide
            let spaceship = entityCreator.createSpaceship(index: index, at: position, of: SPSizes.spaceship)
            initialPlayerIndexToIdMap[index] = spaceship.id
        }
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let spaceship = SPCollisions.spaceshipBitmask
        let rock = SPCollisions.rockBitmask
        let bullet = SPCollisions.bulletBitmask
        let powerup = SPCollisions.powerupBitmask

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
        systemManager.register(SPInputSystem(for: entityManager))
        systemManager.register(SPRoundSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(BulletAgeSystem(for: entityManager))
        systemManager.register(GunSystem(for: entityManager))
        systemManager.register(AutoRotateSystem(for: entityManager))
        systemManager.register(WraparoundSystem(for: entityManager))
        systemManager.register(SPAnimationCreatorSystem(for: entityManager))
        systemManager.register(SPScoreSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(PowerupSystem(for: entityManager))
        systemManager.register(SPGameOverSystem(for: entityManager, eventFirer: eventManager,
                                                onGameOver: handleGameOver))
        systemManager.register(AnimationSystem(for: entityManager))
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
