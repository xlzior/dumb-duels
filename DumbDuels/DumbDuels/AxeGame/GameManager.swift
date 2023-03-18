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
        let viewController = renderSystemDetails.gameController as? UIViewController
        simulator.view.showsFPS = true
        simulator.view.showsPhysics = true
        simulator.view.showsNodeCount = true
        viewController?.view = simulator.view

        setUpEntities()
        setUpSystems()
        startGame()
    }

    private func setUpEntities() {
        for playerIndex in 0...1 {
            let playerPosition = Positions.players[playerIndex]
            let faceDirection: FaceDirection = playerIndex == 0 ? .right : .left

            let horizontalOffset = (Sizes.player.width / 2 + Sizes.axe.height / 2 + 10) * faceDirection.rawValue
            print("horizontalOffset")

            let verticalOffset = (Sizes.player.height / 2 + Sizes.platform.height / 2) * -1
            let platform = entityCreator.createPlatform(
                withVerticalOffset: verticalOffset,
                from: playerPosition,
                of: Sizes.platform
            )

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
            playerIds[playerIndex] = player.id.id
            axeIds[playerIndex] = axe.id.id
            platformIds[playerIndex] = platform.id.id

            renderSystemDetails.gameController.registerPlayerID(playerIndex: playerIndex, playerEntityID: player.id)

            if playerIndex == 0 {
                event = ThrowAxeEvent(entityId: axe.id, throwerId: player.id, faceDirection: faceDirection)
            }
        }

    }

    private func setUpSystems() {
        systemManager.register(InputSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(PlayerAxeSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(RoundSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(PhysicsSystem(
            for: entityManager,
            eventManager: eventManager,
            scene: simulator.gameScene
        ))
        systemManager.register(CollisionSystem(for: entityManager, eventManager: eventManager))
        systemManager.register(ScoreSystem(for: entityManager, eventManager: eventManager))
//        systemManager.register(RenderSystem(
//            for: entityManager,
//            eventManger: eventManager,
//            details: renderSystemDetails
//        ))
    }

    private func updateSystems() {
        systemManager.update()
    }

    private func startGame() {
        simulator.start()

        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            print("Event fired!")
            guard let throwAxeEvent = self.event else {
                return
            }
            self.eventManager.fire(throwAxeEvent)
            timer.invalidate()
        }
    }
}

// MARK: - Handle Input
extension GameManager {
    func handleButtonPress(for entityID: EntityID) {
        eventManager.fire(ButtonPressEvent(entityId: entityID))
    }

    func handleButtonLongPress(for entityID: EntityID) {

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
//        print("Player 1: \(physicsSystem.getPosition(of: playerIds[0]))")
//        print("Axe 1: \(physicsSystem.getPosition(of: axeIds[0]))")
//        print("Platform 1: \(physicsSystem.getPosition(of: platformIds[0]))")
//
//        print("Player 2: \(physicsSystem.getPosition(of: playerIds[1]))")
//        print("Axe 2: \(physicsSystem.getPosition(of: axeIds[1]))")
//        print("Platform 2: \(physicsSystem.getPosition(of: platformIds[1]))")
//
//        print("Player 1: \(physicsSystem.getBitmasks(of: playerIds[0]))")
//        print("Axe 1: \(physicsSystem.getPosition(of: axeIds[0]))")
//        print("Platform 1: \(physicsSystem.getBitmasks(of: platformIds[0]))")
//
//        print("Player 2: \(physicsSystem.getBitmasks(of: playerIds[1]))")
//        print("Axe 2: \(physicsSystem.getBitmasks(of: axeIds[1]))")
//        print("Platform 2: \(physicsSystem.getBitmasks(of: platformIds[1]))")

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
        print(simulator.gameScene.bodyIDPhysicsMap[bodyA]?.position)
        print(simulator.gameScene.bodyIDPhysicsMap[bodyB]?.position)
        collisionSystem.handleCollision(firstId: bodyA, secondId: bodyB)
    }

    func didContactEnd(for bodyA: BodyID, and bodyB: BodyID) {
    }
}
