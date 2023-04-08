//
//  GameManager.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

open class GameManager: GameSceneDelegate, PhysicsContactDelegate {
    private var gameController: GameController

    public let entityManager: EntityManager
    public let systemManager: SystemManager
    public let eventManager: EventManager

    public var simulator: Simulatable
    public var initialPlayerIndexToIdMap: [Int: EntityID]
    private var isGameOver: Bool

    // TODO: is this violating any software design principles...
    private var isUsingSoundSystem = false
    private var isUsingAnimationSystem = false
    private var isUsingPhysicsSystem = false
    private var physicsContactHandlers: PhysicsSystem.ContactHandlerMap?
    private var isUsingRenderSystem = false
    private var isUsingGameOverSystem = false
    private var gameOverAssets: GameOverAssets?
    private var isUsingAutoRotateSystem = false

    public init(gameController: GameViewController) {
        self.gameController = gameController

        self.entityManager = EntityManager()
        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)
        self.systemManager = systemManager
        self.eventManager = eventManager

        self.simulator = Simulator()
        self.initialPlayerIndexToIdMap = [Int: EntityID]()
        self.isGameOver = false
        simulator.gameScene.gameSceneDelegate = self
        simulator.gameScene.physicsContactDelegate = self

        setUpEntities()
        setUpUserSystems()
        setUpInternalSystems()
        setUpPlayerIndexToIdMappings()
        self.gameController.onBackToHomePage = self.stopGameLoop
        startGame()
    }

    open func setUpEntities() {

    }

    open func setUpUserSystems() {

    }

    public func useSoundSystem() {
        isUsingSoundSystem = true
    }

    public func useAnimationSystem() {
        isUsingAnimationSystem = true
    }

    public func useRenderSystem() {
        isUsingRenderSystem = true
    }

    public func usePhysicsSystem(withContactHandlers: PhysicsSystem.ContactHandlerMap) {
        isUsingPhysicsSystem = true
        physicsContactHandlers = withContactHandlers
    }

    public func useGameOverSystem(
        gameStartText: String,
        gameTieText: String,
        gameWonTexts: [String],
        gameStartSound: URL,
        gameEndSound: URL
    ) {
        isUsingGameOverSystem = true
        gameOverAssets = GameOverAssets(
            gameStartText: gameStartText,
            gameTieText: gameTieText,
            gameWonTexts: gameWonTexts,
            gameStartSound: gameStartSound,
            gameEndSound: gameEndSound
        )
    }

    public func useAutoRotateSystem() {
        isUsingAutoRotateSystem = true
    }

    private func setUpInternalSystems() {
        if isUsingAutoRotateSystem {
            systemManager.register(AutoRotateSystem(for: entityManager))
        }

        if isUsingGameOverSystem {
            guard let gameOverAssets else {
                return assertionFailure("No game over assets found")
            }
            systemManager.register(GameOverSystem(
                for: entityManager, onGameOver: handleGameOver, assets: gameOverAssets))
        }

        if isUsingSoundSystem {
            systemManager.register(SoundSystem(for: entityManager))
        }

        if isUsingAnimationSystem {
            systemManager.register(AnimationSystem(for: entityManager))
        }

        if isUsingPhysicsSystem {
            guard let physicsContactHandlers else {
                return assertionFailure("No contact handlers found")
            }
            systemManager.register(PhysicsSystem(
                for: entityManager, eventFirer: eventManager,
                scene: simulator.gameScene, contactHandlers: physicsContactHandlers))
        }

        if isUsingRenderSystem {
            systemManager.register(RenderSystem(
                for: entityManager,
                eventManger: eventManager,
                gameController: gameController
            ))
        }
    }

    private func setUpPlayerIndexToIdMappings() {
        guard let firstId = initialPlayerIndexToIdMap[0],
              let secondId = initialPlayerIndexToIdMap[1] else {
            return
        }
        systemManager.updateIndexToIdMapping(firstId: firstId, secondId: secondId)
    }

    private func startGame() {
        simulator.start()
    }

    func handleButtonDown(for playerIndex: Int) {
        eventManager.fire(ButtonDownEvent(index: playerIndex))
    }

    func handleButtonUp(for playerIndex: Int) {
        eventManager.fire(ButtonUpEvent(index: playerIndex))
    }

    open func gameLoopDidStart() {

    }

    open func update(with timeInterval: Double) {

    }

    open func didSimulatePhysics() {

    }

    open func didFinishUpdate() {
        if let physicsSystem = systemManager.get(ofType: PhysicsSystem.self) {
            physicsSystem.syncFromPhysicsEngine()
        }
        if !isGameOver {
            eventManager.pollAll()
        }
        systemManager.update()
    }

    open func didContactBegin(for entityA: EntityID, and entityB: EntityID) {
        guard let physicsSystem = systemManager.get(ofType: PhysicsSystem.self) else {
            return
        }
        physicsSystem.handleCollision(firstId: entityA, secondId: entityB)
    }

    open func didContactEnd(for entityA: EntityID, and entityB: EntityID) {

    }

    open func stopGameLoop() {
        print("simulator stopped!")
        simulator.stop()
    }

    open func handleGameOver() {
        print("game over!")
        isGameOver = true
    }
}
