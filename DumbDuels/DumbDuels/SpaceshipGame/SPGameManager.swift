//
//  SPGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPGameManager: GameManager {
    private var entityCreator: SPEntityCreator?

    override func setUpEntities() {
        let creator = SPEntityCreator(entityManager: entityManager)
        entityCreator = creator

        let (firstPosition, secondPosition) = SPSizes.getSpaceshipResetPositions()
        for index in 0...1 {
            let position = index == 0 ? firstPosition : secondPosition
            let spaceship = creator.createSpaceship(index: index, at: position, of: SPSizes.spaceship)
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

    override func setUpUserSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(SPInputSystem(for: entityManager))
        systemManager.register(SPRoundSystem(for: entityManager, eventFirer: eventManager, entityCreator: creator))
        systemManager.register(BulletAgeSystem(for: entityManager))
        systemManager.register(GunSystem(for: entityManager, entityCreator: creator))
        systemManager.register(AutoRotateSystem(for: entityManager))
        systemManager.register(WraparoundSystem(for: entityManager))
        systemManager.register(SPAnimationCreatorSystem(for: entityManager, entityCreator: creator))
        systemManager.register(SPScoreSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(PowerupSystem(for: entityManager, entityCreator: creator))
        systemManager.register(SPGameOverSystem(
            for: entityManager, eventFirer: eventManager,
            entityCreator: creator, onGameOver: handleGameOver))

        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }
}
