//
//  BlockSpawnSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

// This system is responsible for checking whether each player is eligible
// to spawn blocks on each update, and spawns a block if they do not have active blocks
// that can be controlled
class BlockSpawnSystem: System {
    private let entityManager: EntityManager
    private let eventFirer: EventFirer

    private let entityCreator: TTEntityCreator
    private let controlBlocks: Assemblage3<BlockComponent, HasGuidelineComponent, PhysicsComponent>
    private let landedBlocks: Assemblage3<BlockComponent, PhysicsComponent, PositionComponent>
    private let allBlocks: Assemblage2<BlockComponent, PhysicsComponent>
    private let players: Assemblage2<TTPlayerComponent, ScoreComponent>

    private var isGameOver = false

    init(for entityManager: EntityManager, entityCreator: TTEntityCreator, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.players = entityManager.assemblage(requiredComponents: TTPlayerComponent.self, ScoreComponent.self)
        self.controlBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self,
                                                      HasGuidelineComponent.self, PhysicsComponent.self)
        self.landedBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self,
                                                     PhysicsComponent.self, PositionComponent.self,
                                                     excludedComponents: HasGuidelineComponent.self)
        self.allBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self, PhysicsComponent.self)
        self.eventFirer = eventFirer
        eventFirer.fire(GameStartEvent())
    }

    func update() {
        guard !isGameOver else {
            return
        }
        for (entity, player, _) in players.entityAndComponents {
            guard player.currentControllingBlockId == nil else {
                continue
            }
            let newBlock = spawnRandomBlockForPlayer(playerId: entity.id, index: player.index)
            player.moveDirection = 1
            player.currentControllingBlockId = newBlock.id
        }
    }

    private func spawnRandomBlockForPlayer(playerId: EntityID, index: Int) -> Entity {
        var playerCenter: CGPoint
        if index == 0 {
            playerCenter = TTPositions.player1BlockSpawn
        } else {
            playerCenter = TTPositions.player2BlockSpawn
        }
        let blockType = TTAssets.getRandomBlockType()
        let maxBlockDimesions = max(blockType.width, blockType.length) * TTSizes.blockUnitSize
        let rangeForRandomness = Sizes.game.width / 4 - TTSizes.separatorSize.width / 2 - maxBlockDimesions
        let randomXOffet = CGFloat.random(in: -rangeForRandomness...rangeForRandomness)
        let spawnPosition = CGPoint(x: playerCenter.x + randomXOffet, y: playerCenter.y)
        return entityCreator.createBlock(ofType: blockType, at: spawnPosition, for: playerId)
    }

    func handleBlockCollision(controlBlockId: EntityID, landedBlockId: EntityID) {
        guard let (block, hasGuideline, physics) = controlBlocks.getComponents(for: controlBlockId),
              let (player, _) = players.getComponents(for: block.playerId),
              landedBlocks.isMember(entityId: landedBlockId)  else {
            return
        }
        changeControlBlockToLandedBlock(controlBlockId, hasGuideline, player, physics)
    }

    func handleBlockCollisionWithPlatform(for controlBlockId: EntityID) {
        guard let (block, hasGuideline, physics) = controlBlocks.getComponents(for: controlBlockId),
              let (player, _) = players.getComponents(for: block.playerId) else {
            return
        }
        changeControlBlockToLandedBlock(controlBlockId, hasGuideline, player, physics)
    }

    // This function assumes that all checks/guards have already been done by calling function
    private func changeControlBlockToLandedBlock(_ blockId: EntityID,
                                                 _ hasGuiding: HasGuidelineComponent,
                                                 _ currentControllingPlayer: TTPlayerComponent,
                                                 _ physics: PhysicsComponent) {
        // Change physics component fields for the control block
        physics.restitution = TTPhysics.landedBlockCor
        physics.affectedByGravity = TTPhysics.landedBlockGravity
        physics.ownBitmask = TTCollisions.landedBlockBitmask

        // At this point, may not have updated to physics engine
        physics.collideBitmask = TTCollisions.landedBlockCollideBitmask
        physics.contactBitmask = TTCollisions.landedBlockContactBitmask
        physics.velocity.dy = 0.0

        // Destroy the guiding line entity for the control block and remove the has-component
        entityManager.destroy(entityId: hasGuiding.guidelineId)
        entityManager.remove(componentType: HasGuidelineComponent.typeId, from: blockId)

        // Check and remove the controlBlockId from the player's currentlyControllingBlockId
        if currentControllingPlayer.currentControllingBlockId == blockId {
            currentControllingPlayer.currentControllingBlockId = nil
        }

        // Fire event so that input system can no longer control the controlled block
        eventFirer.fire(RemoveBlockControlEvent(blockIdToRemoveControl: blockId))
    }

    func removeAndCleanupBlock(blockId: EntityID) {
        guard let (_, physics) = allBlocks.getComponents(for: blockId) else {
            return
        }

        // Destroy physics component and entity
        physics.toBeRemoved = true
        physics.shouldDestroyEntityWhenRemove = true

        // If is under control remove block control from player and destroy guide line
        guard let (controlBlock, hasGuide, _) = controlBlocks.getComponents(for: blockId) else {
            return
        }

        entityManager.destroy(entityId: hasGuide.guidelineId)
        entityManager.remove(componentType: HasGuidelineComponent.typeId, from: blockId)

        guard let (currentControllingPlayer, _) = players.getComponents(for: controlBlock.playerId),
              currentControllingPlayer.currentControllingBlockId == blockId else {
            return
        }

        currentControllingPlayer.currentControllingBlockId = nil

        // Fire event so that input system can no longer control the controlled block
        eventFirer.fire(RemoveBlockControlEvent(blockIdToRemoveControl: blockId))
    }

    func handleGameOver() {
        isGameOver = true
    }
}
