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

    private var internalSystems = [InternalSystem]()

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
        setUpInputSystemMappings()
        self.gameController.onBackToHomePage = self.stopGameLoop
        startGame()
    }

    open func setUpEntities() {

    }

    open func setUpUserSystems() {

    }

    public func useSoundSystem() {
        internalSystems.append(SoundSystem(for: entityManager))
    }

    public func useAnimationSystem() {
        internalSystems.append(AnimationSystem(for: entityManager))
    }

    public func useRenderSystem() {
        internalSystems.append(RenderSystem(
            for: entityManager,
            eventManager: eventManager,
            gameController: gameController
        ))
    }

    public func usePhysicsSystem(withContactHandlers: PhysicsSystem.ContactHandlerMap) {
        internalSystems.append(PhysicsSystem(
            for: entityManager, eventFirer: eventManager,
            scene: simulator.gameScene, contactHandlers: withContactHandlers))
    }

    public func useGameOverSystem(
        gameStartText: String,
        gameTieText: String,
        gameWonTexts: [String],
        gameStartSound: @escaping () -> Sound,
        gameEndSound: @escaping () -> Sound,
        winningScore: Int = 3
    ) {
        let gameOverAssets = GameOverAssets(
            gameStartText: gameStartText,
            gameTieText: gameTieText,
            gameWonTexts: gameWonTexts,
            gameStartSound: gameStartSound,
            gameEndSound: gameEndSound
        )
        internalSystems.append(GameOverSystem(
            for: entityManager, eventFirer: eventManager,
            onGameOver: handleGameOver, assets: gameOverAssets,
            winningScore: winningScore))
    }

    public func useAutoRotateSystem() {
        internalSystems.append(AutoRotateSystem(for: entityManager))
    }

    public func useParticleSystem() {
        internalSystems.append(ParticleSystem(for: entityManager))
    }

    private func setUpInternalSystems() {
        internalSystems.sort { $0.priority <= $1.priority }

        internalSystems.forEach { system in
            systemManager.register(system)
        }
    }

    private func setUpInputSystemMappings() {
        guard let firstId = initialPlayerIndexToIdMap[0],
              let secondId = initialPlayerIndexToIdMap[1] else {
            return
        }
        systemManager.setupInputSystemMapping(firstPlayedId: firstId, secondPlayerId: secondId)
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
        simulator.stop()
    }

    open func handleGameOver() {
        isGameOver = true
    }
}
