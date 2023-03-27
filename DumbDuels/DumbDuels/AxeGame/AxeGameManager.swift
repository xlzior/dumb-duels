//
//  AxeGameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit
import DuelKit

class AxeGameManager: GameManager {
    var entityCreator: EntityCreator?

    override func setUpEntities() {
        let creator = EntityCreator(entityManager: entityManager)
        entityCreator = creator

        for playerIndex in 0...1 {
            let playerPosition = Positions.players[playerIndex]
            let faceDirection: FaceDirection = playerIndex == 0 ? .right : .left

            let verticalOffset = (Sizes.player.height / 2 + Sizes.platform.height / 2) * -1
            let platform = creator.createPlatform(
                withVerticalOffset: verticalOffset,
                from: playerPosition,
                of: Sizes.platform
            )

            let axe = creator.createAxe(
                withHorizontalOffset: Sizes.axeOffsetFromPlayer(facing: faceDirection),
                from: playerPosition,
                of: Sizes.axe,
                facing: faceDirection
            )

            let player = creator.createPlayer(
                index: playerIndex,
                at: playerPosition,
                facing: faceDirection,
                of: Sizes.player,
                holding: axe.id,
                onPlatform: platform.id
            )

            renderSystemDetails.gameController.registerPlayerID(playerIndex: playerIndex, playerEntityID: player.id)
        }

        _ = creator.createLava(at: Positions.lava, of: Sizes.lava)

        for wallIndex in 0..<3 {
            _ = creator.createWall(at: Positions.walls[wallIndex], of: Sizes.walls[wallIndex])
        }

        for pegPosition in Positions.pegs {
            _ = creator.createPeg(at: pegPosition, of: Sizes.peg)
        }
    }

    private func getContactHandlers() -> PhysicsSystem.ContactHandlerMap {
        var contactHandlers = PhysicsSystem.ContactHandlerMap()
        let player = Collisions.playerBitmask
        let axe = Collisions.axeBitmask
        let platform = Collisions.platformBitmask

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

        return contactHandlers
    }

    override func setUpSystems() {
        guard let creator = entityCreator else {
            return
        }

        systemManager.register(AxeGameInputSystem(for: entityManager))
        systemManager.register(PlayerPlatformSyncSystem(for: entityManager))
        systemManager.register(PlayerSystem(for: entityManager))
        systemManager.register(AxeParticleSystem(for: entityManager))
        systemManager.register(RoundSystem(for: entityManager, eventFirer: eventManager, entityCreator: creator))
        systemManager.register(PhysicsSystem(for: entityManager, eventFirer: eventManager,
                                             scene: simulator.gameScene, contactHandlers: getContactHandlers()))
        systemManager.register(ScoreSystem(for: entityManager))
        systemManager.register(GameOverSystem(for: entityManager, entityCreator: creator))
        systemManager.register(LavaSystem(entityCreator: creator))
        systemManager.register(AnimationSystem(for: entityManager))
        systemManager.register(RenderSystem(
            for: entityManager,
            eventManger: eventManager,
            details: renderSystemDetails
        ))
    }

    override func didFinishUpdate() {
        if let physicsSystem = systemManager.get(ofType: PhysicsSystem.self) {
            physicsSystem.syncFromPhysicsEngine()
        }

        eventManager.pollAll()
        systemManager.update()
    }
}
