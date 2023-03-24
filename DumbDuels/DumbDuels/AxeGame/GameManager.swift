//
//  GameManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

class GameManager {
    private let renderSystemDetails: RenderSystemDetails

    private let entityManager: EntityManager
    private let entityCreator: EntityCreator

    private let systemManager: SystemManager
    private let eventManager: EventManager

    private let simulator: Simulator

    var event: Event?
    var useSpriteKitView = false

    init(renderSystemDetails: RenderSystemDetails) {
        self.renderSystemDetails = renderSystemDetails

        let entityManager = EntityManager()
        let entityCreator = EntityCreator(entityManager: entityManager)
        self.entityManager = entityManager
        self.entityCreator = entityCreator

        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)
        self.systemManager = systemManager
        self.eventManager = eventManager

        self.simulator = Simulator()
        simulator.gameScene.gameSceneDelegate = self
        simulator.gameScene.physicsContactDelegate = self
        if useSpriteKitView {
            let viewController = renderSystemDetails.gameController as? UIViewController
            simulator.view.showsFPS = true
            simulator.view.showsPhysics = true
            simulator.view.showsNodeCount = true
            viewController?.view = simulator.view
        }

        setUpEntities()
        setUpSystems()
        startGame()
    }

    private func setUpEntities() {
        for playerIndex in 0...1 {
            let playerPosition = Positions.players[playerIndex]
            let faceDirection: FaceDirection = playerIndex == 0 ? .right : .left

            let verticalOffset = (Sizes.player.height / 2 + Sizes.platform.height / 2) * -1
            let platform = entityCreator.createPlatform(
                withVerticalOffset: verticalOffset,
                from: playerPosition,
                of: Sizes.platform
            )

            let axe = entityCreator.createAxe(
                withHorizontalOffset: Sizes.axeOffsetFromPlayer(facing: faceDirection),
                from: playerPosition,
                of: Sizes.axe,
                facing: faceDirection
            )

            let player = entityCreator.createPlayer(
                index: playerIndex,
                at: playerPosition,
                facing: faceDirection,
                of: Sizes.player,
                holding: axe.id,
                onPlatform: platform.id
            )

            renderSystemDetails.gameController.registerPlayerID(playerIndex: playerIndex, playerEntityID: player.id)
        }

        for wallIndex in 0..<3 {
            let wall = entityCreator.createWall(at: Positions.walls[wallIndex], of: Sizes.walls[wallIndex])
        }

        for pegPosition in Positions.pegs {
            let peg = entityCreator.createPeg(at: pegPosition, of: Sizes.peg)
        }
    }

    private func setUpSystems() {
        systemManager.register(InputSystem(for: entityManager))
        systemManager.register(PlayerPlatformSyncSystem(for: entityManager))
        systemManager.register(PlayerSystem(for: entityManager))
        systemManager.register(RoundSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(PhysicsSystem(for: entityManager, eventFirer: eventManager, scene: simulator.gameScene))
        systemManager.register(ScoreSystem(for: entityManager))
        if !useSpriteKitView {
            systemManager.register(RenderSystem(
                for: entityManager,
                eventManger: eventManager,
                details: renderSystemDetails
            ))
        }
    }

    private func startGame() {
        simulator.start()

        if useSpriteKitView {
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                guard let throwAxeEvent = self.event else {
                    return
                }
                self.eventManager.fire(throwAxeEvent)
                timer.invalidate()
            }
        }
    }
}

// MARK: - Handle Input
extension GameManager {
    func handleButtonDown(for entityID: EntityID) {
        eventManager.fire(ButtonDownEvent(entityId: entityID))
    }

    func handleButtonUp(for entityID: EntityID) {
        eventManager.fire(ButtonUpEvent(entityId: entityID))
    }
}

// MARK: - GameSceneDelegate
extension GameManager: GameSceneDelegate {
    func gameLoopDidStart() {

    }

    func update(with timeInterval: Double) {

    }

    func didSimulatePhysics() {

    }

    func didFinishUpdate() {
        guard let physicsSystem = systemManager.get(ofType: PhysicsSystem.self) else {
            return
        }

        physicsSystem.syncFromPhysicsEngine()
        eventManager.pollAll()
        systemManager.update()
    }
}

extension GameManager: PhysicsContactDelegate {
    func didContactBegin(for bodyA: BodyID, and bodyB: BodyID) {
        guard let physicsSystem = systemManager.get(ofType: PhysicsSystem.self) else {
            return
        }
        physicsSystem.handleCollision(firstId: bodyA, secondId: bodyB)
    }

    func didContactEnd(for bodyA: BodyID, and bodyB: BodyID) {
    }
}
