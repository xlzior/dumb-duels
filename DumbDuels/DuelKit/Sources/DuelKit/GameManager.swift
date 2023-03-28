//
//  GameManager.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 16/3/23.
//

import UIKit

open class GameManager: GameSceneDelegate, PhysicsContactDelegate {
    public let renderSystemDetails: RenderSystemDetails

    public let entityManager: EntityManager
    public let systemManager: SystemManager
    public let eventManager: EventManager

    public var simulator: Simulatable

    public init(renderSystemDetails: RenderSystemDetails) {
        self.renderSystemDetails = renderSystemDetails

        self.entityManager = EntityManager()
        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)
        self.systemManager = systemManager
        self.eventManager = eventManager

        self.simulator = Simulator()
        simulator.gameScene.gameSceneDelegate = self
        simulator.gameScene.physicsContactDelegate = self

        setUpEntities()
        setUpSystems()
        startGame()
    }

    open func setUpEntities() {

    }

    open func setUpSystems() {

    }

    private func startGame() {
        simulator.start()
    }

    func handleButtonDown(for entityID: EntityID) {
        eventManager.fire(ButtonDownEvent(entityId: entityID))
    }

    func handleButtonUp(for entityID: EntityID) {
        eventManager.fire(ButtonUpEvent(entityId: entityID))
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

        eventManager.pollAll()
        systemManager.update()
    }

    open  func didContactBegin(for entityA: EntityID, and entityB: EntityID) {
        guard let physicsSystem = systemManager.get(ofType: PhysicsSystem.self) else {
            return
        }
        physicsSystem.handleCollision(firstId: entityA, secondId: entityB)
    }

    open func didContactEnd(for entityA: EntityID, and entityB: EntityID) {

    }
}
