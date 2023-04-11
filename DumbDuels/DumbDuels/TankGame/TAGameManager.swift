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

        let (position1, position2) = TAPositions.randomTankPositions()
        for index in 0...1 {
            let tank = creator.createTank(index: index,
                                          at: index == 0 ? position1 : position2,
                                          of: TASizes.tank)

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
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let tank = TACollisions.tankBitmask
        let cannonball = TACollisions.cannonballBitmask
        let wall = TACollisions.wallBitmask
        let sideWall = TACollisions.sideWallBitmask

        contactHandlers[Pair(first: tank, second: cannonball)] = { (tank: EntityID, cannonball: EntityID) -> Event in
            CannonballHitTankEvent(cannonballId: cannonball, tankId: tank)
        }

        contactHandlers[Pair(first: cannonball, second: tank)] = { (cannonball: EntityID, tank: EntityID) -> Event in
            CannonballHitTankEvent(cannonballId: cannonball, tankId: tank)
        }

        contactHandlers[Pair(first: wall, second: cannonball)] = { (_: EntityID, _: EntityID) -> Event in
            CollideSoundEvent()
        }

        contactHandlers[Pair(first: cannonball, second: wall)] = { (_: EntityID, _: EntityID) -> Event in
            CollideSoundEvent()
        }

        contactHandlers[Pair(first: sideWall, second: cannonball)] = { (_: EntityID, _: EntityID) -> Event in
            CollideSoundEvent()
        }

        contactHandlers[Pair(first: cannonball, second: sideWall)] = { (_: EntityID, _: EntityID) -> Event in
            CollideSoundEvent()
        }

        return contactHandlers
    }

    override func setUpUserSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(TAInputSystem(for: entityManager, entityCreator: creator))
        systemManager.register(TAScoreSystem(for: entityManager))
        systemManager.register(CannonballSystem(for: entityManager))
        systemManager.register(TARoundSystem(for: entityManager, eventFirer: eventManager))

        useParticleSystem()
        useAutoRotateSystem()
        useGameOverSystem(gameStartText: Assets.battleText,
                          gameTieText: Assets.gameTiedText,
                          gameWonTexts: Assets.gameWonText,
                          gameStartSound: Sounds.battleSound,
                          gameEndSound: Sounds.gameEndSound)
        useSoundSystem()
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }
}
