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

        // Create score lines
        for scoreLinePosition in TTPositions.getScoreLinePositions() {
            creator.createScoreLine(at: scoreLinePosition, of: TTSizes.scoreLineSize)
        }

        // Create player entities
        for index in 0...1 {
            let player = creator.createPlayer(index: index)
            initialPlayerIndexToIdMap[index] = player.id
        }
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let controlBlock = TTCollisions.controlBlockBitmask
        let landedBlock = TTCollisions.landedBlockBitmask
        let wall = TTCollisions.wallBitmask
        let platform = TTCollisions.platformBitmask
        let scoreLine = TTCollisions.scoreLineBitmask

        contactHandlers[Pair(first: landedBlock, second: scoreLine)] = { (landedBlock: EntityID, scoreLine: EntityID) -> Event in
            BlockContactScorelineEvent(blockId: landedBlock, scoreLineId: scoreLine)
        }

        contactHandlers[Pair(first: scoreLine, second: landedBlock)] = { (scoreLine: EntityID, landedBlock: EntityID) -> Event in
            BlockContactScorelineEvent(blockId: landedBlock, scoreLineId: scoreLine)
        }

        contactHandlers[Pair(first: landedBlock, second: controlBlock)] = { (landedBlock: EntityID, controlBlock: EntityID) -> Event in
            BlockHitBlockEvent(controlBlockId: controlBlock, landedBlockId: landedBlock)
        }

        contactHandlers[Pair(first: controlBlock, second: landedBlock)] = { (controlBlock: EntityID, landedBlock: EntityID) -> Event in
            BlockHitBlockEvent(controlBlockId: controlBlock, landedBlockId: landedBlock)
        }

        contactHandlers[Pair(first: controlBlock, second: platform)] = { (controlBlock: EntityID, _: EntityID) -> Event in
            ControlBlockHitPlatformEvent(controlBlockId: controlBlock)
        }

        contactHandlers[Pair(first: platform, second: controlBlock)] = { (_: EntityID, controlBlock: EntityID) -> Event in
            ControlBlockHitPlatformEvent(controlBlockId: controlBlock)
        }

        return contactHandlers
    }

    override func setUpUserSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(TTInputSystem(for: entityManager))
        systemManager.register(TTScoreSystem(for: entityManager))
        systemManager.register(BlockSpawnSystem(for: entityManager, entityCreator: creator))
        // To be save, must be after BlockSpawnSystem, so that we can sync the guideline position after block spawn
        systemManager.register(GuidelineSystem(for: entityManager))

        useParticleSystem()
        useAutoRotateSystem()
        useGameOverSystem(gameStartText: Assets.battleText,
                          gameTieText: Assets.gameTiedText,
                          gameWonTexts: Assets.gameWonText,
                          gameStartSound: Sounds.battleSound,
                          gameEndSound: Sounds.gameEndSound)
        // useSoundSystem()
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
        useAnimationSystem()
    }

}
