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
    private var axeIds: [String] = ["asdasd", "asdasd"]
    private var platformIds: [String] = ["asdasd", "asdasdasd"]
    private var playerIds: [String] = ["asdasd", "asdasd"]

    var event: Event?
    var useSpriteKitView: Bool = false

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
            let wallPosition = Positions.walls[playerIndex]

            let verticalOffset = (Sizes.player.height / 2 + Sizes.platform.height / 2) * -1
            let platform = entityCreator.createPlatform(
                withVerticalOffset: verticalOffset,
                from: playerPosition,
                of: Sizes.platform
            )

            let horizontalOffset = (Sizes.player.width / 2 + Sizes.axe.height / 2 + 1) * faceDirection.rawValue
            let axe = entityCreator.createAxe(
                withHorizontalOffset: horizontalOffset,
                from: playerPosition,
                of: Sizes.axe
            )

            let player = entityCreator.createPlayer(
                at: playerPosition,
                facing: faceDirection,
                of: Sizes.player,
                holding: axe.id
            )

            let wall = entityCreator.createWall(at: wallPosition, of: Sizes.wall)

            playerIds[playerIndex] = player.id.id
            axeIds[playerIndex] = axe.id.id
            platformIds[playerIndex] = platform.id.id

            renderSystemDetails.gameController.registerPlayerID(playerIndex: playerIndex, playerEntityID: player.id)
        }
    }

    private func setUpSystems() {
        systemManager.register(InputSystem(for: entityManager))
        systemManager.register(PlayerSystem(for: entityManager))
        systemManager.register(RoundSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(PhysicsSystem(for: entityManager, scene: simulator.gameScene))
        systemManager.register(CollisionSystem(for: entityManager, eventFirer: eventManager))
        systemManager.register(ScoreSystem(for: entityManager))
        if !useSpriteKitView {
            systemManager.register(RenderSystem(
                for: entityManager,
                eventManger: eventManager,
                details: renderSystemDetails
            ))
        }
    }

    private func updateSystems() {
        systemManager.update()
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
    func handleButtonPress(for entityID: EntityID) {
        eventManager.fire(ButtonPressEvent(entityId: entityID))
    }

    func handleButtonLongPress(for entityID: EntityID) {
        eventManager.fire(ButtonLongPressEvent(entityId: entityID))
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
        print("Contact between \(bodyA) and \(bodyB) started")
        guard let collisionSystem = systemManager.get(ofType: CollisionSystem.self) else {
            return
        }
        collisionSystem.handleCollision(firstId: bodyA, secondId: bodyB)
    }

    func didContactEnd(for bodyA: BodyID, and bodyB: BodyID) {
    }
}
