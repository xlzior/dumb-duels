//
//  AxeGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit
import DuelKit

class AxeGameManager: GameManager {
    private var entityCreator: EntityCreator?

    override func setUpEntities() {
        let creator = EntityCreator(entityManager: entityManager)
        entityCreator = creator

        for playerIndex in 0...1 {
            let playerPosition = AXPositions.players[playerIndex]
            let faceDirection: FaceDirection = playerIndex == 0 ? .right : .left

            let verticalOffset = (AXSizes.player.height / 2 + AXSizes.platform.height / 2) * -1
            let platform = creator.createPlatform(
                withVerticalOffset: verticalOffset,
                from: playerPosition,
                of: AXSizes.platform,
                index: playerIndex
            )

            let axe = creator.createAxe(
                withHorizontalOffset: AXSizes.axeOffsetFromPlayer(facing: faceDirection),
                from: playerPosition,
                of: AXSizes.axe,
                facing: faceDirection,
                onPlatform: platform.id
            )

            let player = creator.createPlayer(
                index: playerIndex,
                at: playerPosition,
                facing: faceDirection,
                of: AXSizes.player,
                holding: axe.id,
                onPlatform: platform.id
            )
            initialPlayerIndexToIdMap[playerIndex] = player.id
        }

        creator.createLava(at: AXPositions.lava, of: AXSizes.lava)

        for wallIndex in 0..<3 {
            creator.createWall(at: AXPositions.walls[wallIndex], of: AXSizes.walls[wallIndex])
        }

        for pegIndex in 0..<AXPositions.pegs.count {
            creator.createPeg(at: AXPositions.pegs[pegIndex], of: AXSizes.peg, index: pegIndex)
        }
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let player = Collisions.playerBitmask
        let axe = Collisions.axeBitmask
        let platform = Collisions.platformBitmask
        let lava = Collisions.lavaBitmask

        contactHandlers[Pair(first: player, second: axe)] = { (player: EntityID, axe: EntityID) -> Event in
            PlayerHitEvent(entityId: player, hitBy: axe)
        }

        contactHandlers[Pair(first: axe, second: player)] = { (axe: EntityID, player: EntityID) -> Event in
            PlayerHitEvent(entityId: player, hitBy: axe)
        }

        contactHandlers[Pair(first: player, second: platform)] = { (player: EntityID, _: EntityID) -> Event in
            LandEvent(entityId: player)
        }

        contactHandlers[Pair(first: platform, second: player)] = { (_: EntityID, player: EntityID) -> Event in
            LandEvent(entityId: player)
        }

        contactHandlers[Pair(first: axe, second: lava)] = { (axe: EntityID, _: EntityID) -> Event in
            LavaHitEvent(axeEntityId: axe)
        }

        contactHandlers[Pair(first: lava, second: axe)] = { (_: EntityID, axe: EntityID) -> Event in
            LavaHitEvent(axeEntityId: axe)
        }

        return contactHandlers
    }

    override func setUpUserSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(AxeGameInputSystem(for: entityManager))
        systemManager.register(PositionSyncSystem(for: entityManager))
        systemManager.register(PlayerSystem(for: entityManager))
        systemManager.register(RoundSystem(for: entityManager, eventFirer: eventManager, entityCreator: creator))
        systemManager.register(LavaSystem(entityCreator: creator))
        systemManager.register(AxeParticleSystem(for: entityManager, entityCreator: creator))
        systemManager.register(ScoreSystem(for: entityManager))

        useGameOverSystem(gameStartText: AXAssets.battleText,
                          gameTieText: AXAssets.gameTiedText,
                          gameWonTexts: AXAssets.gameWonText)
        useAnimationSystem()
        usePhysicsSystem(withContactHandlers: getContactHandlers())
        useRenderSystem()
    }
}
