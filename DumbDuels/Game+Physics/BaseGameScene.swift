//
//  BasePhysicsScene.swift
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
        guard let bodyA = gameScene?.getPhysicsBody(for: contact.bodyA),
              let bodyB = gameScene?.getPhysicsBody(for: contact.bodyB) else {
            return
        }
        physicsContactDelegate?.didContactBegin(for: bodyA, and: bodyB)
    }

    func didEnd(_ contact: SKPhysicsContact) {
        guard let bodyA = gameScene?.getPhysicsBody(for: contact.bodyA),
              let bodyB = gameScene?.getPhysicsBody(for: contact.bodyB) else {
            return
        }
        physicsContactDelegate?.didContactEnd(for: bodyA, and: bodyB)
    }
}
