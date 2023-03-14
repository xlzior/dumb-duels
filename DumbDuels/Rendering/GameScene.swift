//
//  GameScene.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class GameScene: SKScene {
    var updateDelegate: GameSceneUpdateDelegate?

    override public func sceneDidLoad() {
        updateDelegate?.didSceneGetPresented()
    }

    override public func update(_ currentTime: TimeInterval) {
        updateDelegate?.update(for: currentTime)
    }

    override public func didFinishUpdate() {
        updateDelegate?.didSceneFinishUpdate()
    }

    public func addChild(_ childToAdd: Node) {
        addChild(childToAdd.node)
    }

    public func removeChildren(in nodeArray: [Node]) {
        removeChildren(in: nodeArray.map({ $0.node }))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
//        updateDelegate?.didContactBeginBetween(bodyA: contact.bodyA, bodyB: contact.bodyB)
    }

    public func didEnd(_ contact: SKPhysicsContact) {
//        updateDelegate?.didContactEndBetween(bodyA: contact.bodyA, bodyB: contact.bodyB)
    }
}
