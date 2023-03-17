//
//  BaseGameScene.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

class BaseGameScene: SKScene {
    weak var gameScene: GameScene?
    weak var gameSceneDelegate: GameSceneDelegate?
    weak var physicsContactDelegate: PhysicsContactDelegate?

    override func sceneDidLoad() {
        gameSceneDelegate?.gameLoopDidStart()
    }
}

extension BaseGameScene: SKSceneDelegate {
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        gameSceneDelegate?.update(with: currentTime)
    }

    func didSimulatePhysics(for scene: SKScene) {
        gameSceneDelegate?.didSimulatePhysics()
    }

    func didFinishUpdate(for scene: SKScene) {
        gameSceneDelegate?.didFinishUpdate()
    }
}

extension BaseGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyAID = gameScene?.getBodyID(for: contact.bodyA),
              let bodyBID = gameScene?.getBodyID(for: contact.bodyB) else {
            return
        }
        physicsContactDelegate?.didContactBegin(for: bodyAID, and: bodyBID)
    }

    func didEnd(_ contact: SKPhysicsContact) {
        guard let bodyAID = gameScene?.getBodyID(for: contact.bodyA),
              let bodyBID = gameScene?.getBodyID(for: contact.bodyB) else {
            return
        }
        physicsContactDelegate?.didContactEnd(for: bodyAID, and: bodyBID)
    }
}
