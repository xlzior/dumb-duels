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
    // Blocks under control assemblage should not have physics component
    private let entityManager: EntityManager
    private let eventFirer: EventFirer

    private let entityCreator: TTEntityCreator
    private let controlBlocks: Assemblage3<BlockComponent, HasGuidelineComponent, PhysicsComponent>
    private let landedBlocks: Assemblage2<BlockComponent, PhysicsComponent>
    private let players: Assemblage2<TTPlayerComponent, ScoreComponent>

    init(for entityManager: EntityManager, entityCreator: TTEntityCreator, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.players = entityManager.assemblage(requiredComponents: TTPlayerComponent.self, ScoreComponent.self)
        self.controlBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self, HasGuidelineComponent.self, PhysicsComponent.self)
        self.landedBlocks = entityManager.assemblage(requiredComponents: BlockComponent.self,
                                                     PhysicsComponent.self,
                                                     excludedComponents: HasGuidelineComponent.self)
        self.eventFirer = eventFirer
        eventFirer.fire(GameStartEvent())
    }

    func update() {
        for (entity, player, _) in players.entityAndComponents {
            guard player.currentControllingBlockId == nil else {
                continue
            }
            let newBlock = spawnRandomBlockForPlayer(playerId: entity.id, index: player.index)
            player.moveDirection = 1
            player.currentControllingBlockId = newBlock.id
            print("spawned new block \(newBlock.id) for player \(player.index)")
        }
    }

    private func spawnRandomBlockForPlayer(playerId: EntityID, index: Int) -> Entity {
        var spawnPosition: CGPoint
        if index == 0 {
            spawnPosition = TTPositions.player1BlockSpawn
        } else {
            spawnPosition = TTPositions.player2BlockSpawn
        }
        let blockType = TTAssets.getRandomBlockType()
        return entityCreator.createBlock(ofType: blockType, at: spawnPosition, for: playerId)
    }

    func handleBlockCollision(controlBlockId: EntityID, landedBlockId: EntityID) {
        // print("Collision detected between control: \(controlBlockId) and landed: \(landedBlockId)")
        guard let (block, hasGuideline, physics) = controlBlocks.getComponents(for: controlBlockId),
              let (player, _) = players.getComponents(for: block.playerId),
              landedBlocks.isMember(entityId: landedBlockId)  else {
            return
        }
        changeControlBlockToLandedBlock(controlBlockId, hasGuideline, player, physics)
    }

    func handleBlockCollisionWithPlatform(for controlBlockId: EntityID) {
        // print("Collision detected between control: \(controlBlockId) and platform")
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
        physics.collideBitmask = TTCollisions.landedBlockCollideBitmask
        physics.contactBitmask = TTCollisions.landedBlockContactBitmask
        physics.velocity.dy = 0

        // Destroy the guiding line entity for the control block and remove the has-component
        entityManager.destroy(entityId: hasGuiding.guidelineId)
        entityManager.remove(componentType: HasGuidelineComponent.typeId, from: blockId)

        // Check and remove the controlBlockId from the player's currentlyControllingBlockId
        if currentControllingPlayer.currentControllingBlockId == blockId {
            currentControllingPlayer.currentControllingBlockId = nil
        }
        print("block \(blockId) has landed")

        // Fire event so that input system can no longer control the controlled block
        eventFirer.fire(RemoveBlockControlEvent(blockIdToRemoveControl: blockId))
    }
}
