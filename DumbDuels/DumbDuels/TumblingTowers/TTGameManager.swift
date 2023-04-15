//
//  TTGameManager.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

class TTGameManager: GameManager {
    private var entityCreator: TTEntityCreator?

    override func setUpEntities() {
        let creator = TTEntityCreator(entityManager: entityManager)
        entityCreator = creator

        // Create 2 platforms
        for platformPosition in TTPositions.platforms {
            creator.createPlatform(at: platformPosition, of: TTSizes.platformSize)
        }

        // Create Walls
        for wallPosition in TTPositions.walls {
            creator.createWall(at: wallPosition, of: TTSizes.wallSize)
        }

        // Create separator
        creator.createSeparator(at: TTPositions.separator, of: TTSizes.separatorSize)

        // Create player entities and scoreline
        for index in 0...1 {
            let player = creator.createPlayer(index: index)
            initialPlayerIndexToIdMap[index] = player.id

            for scoreLineYPosition in TTPositions.scoreLineYPositions {
                let scoreLinePosition = CGPoint(x: TTPositions.scoreLineXPositions[index], y: scoreLineYPosition)
                creator.createScoreLine(at: scoreLinePosition, of: TTSizes.scoreLineSize, for: player.id)
            }
        }

        // Create bottom boundary
        creator.createBottomBoundary(at: TTPositions.bottomBoundaryPosition, of: TTSizes.bottomBoundarySize)
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let controlBlock = TTCollisions.controlBlockBitmask
        let landedBlock = TTCollisions.landedBlockBitmask
        let platform = TTCollisions.platformBitmask
        let bottomBoundary = TTCollisions.bottomBoundaryBitmask

        contactHandlers[Pair(landedBlock, controlBlock)] = { (landedBlock: EntityID, controlBlock: EntityID) -> Event in
            BlockHitBlockEvent(controlBlockId: controlBlock, landedBlockId: landedBlock)
        }

        contactHandlers[Pair(controlBlock, landedBlock)] = { (controlBlock: EntityID, landedBlock: EntityID) -> Event in
            BlockHitBlockEvent(controlBlockId: controlBlock, landedBlockId: landedBlock)
        }

        contactHandlers[Pair(controlBlock, platform)] = { (controlBlock: EntityID, _: EntityID) -> Event in
            ControlBlockHitPlatformEvent(controlBlockId: controlBlock)
        }

        contactHandlers[Pair(platform, controlBlock)] = { (_: EntityID, controlBlock: EntityID) -> Event in
            ControlBlockHitPlatformEvent(controlBlockId: controlBlock)
        }

        contactHandlers[Pair(landedBlock, bottomBoundary)] = { (landedBlock: EntityID, _: EntityID) -> Event in
            BlockOutOfGameEvent(blockId: landedBlock)
        }

        contactHandlers[Pair(bottomBoundary, landedBlock)] = { (_: EntityID, landedBlock: EntityID) -> Event in
            BlockOutOfGameEvent(blockId: landedBlock)
        }

        contactHandlers[Pair(bottomBoundary, controlBlock)] = { (_: EntityID, controlBlock: EntityID) -> Event in
            BlockOutOfGameEvent(blockId: controlBlock)
        }

        contactHandlers[Pair(controlBlock, bottomBoundary)] = { (controlBlock: EntityID, _: EntityID) -> Event in
            BlockOutOfGameEvent(blockId: controlBlock)
        }

        return contactHandlers
    }

    override func setUpUserSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(TTInputSystem(for: entityManager))
        systemManager.register(TTScoreSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(BlockSpawnSystem(for: entityManager, entityCreator: creator, eventFirer: eventManager))
        // To be safe, must be after BlockSpawnSystem, so that we can sync the guideline position after block spawn
        systemManager.register(GuidelineSystem(for: entityManager))

        useParticleSystem()
        useAutoRotateSystem()
        useGameOverSystem(gameStartText: Assets.battleText,
                          gameTieText: Assets.gameTiedText,
                          gameWonTexts: Assets.gameWonText,
                          gameStartSound: Sounds.battleSound,
                          gameEndSound: Sounds.gameEndSound,
                          winningScore: TTConstants.winningScore)
        // useSoundSystem()
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }

}
