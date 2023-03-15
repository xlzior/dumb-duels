//
//  PhysicsScene.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

public class GameScene {
    var baseGameScene: BaseGameScene
    var nodes: [Node]
//    var entityNodeMap: [Entity: Node]

    public var gameSceneDelegate: GameSceneDelegate? {
        get { baseGameScene.gameSceneDelegate }
        set { baseGameScene.gameSceneDelegate = newValue }
    }

    public var physicsContactDelegate: PhysicsContactDelegate? {
        get { baseGameScene.physicsContactDelegate }
        set { baseGameScene.physicsContactDelegate = newValue }
    }

    public init() {
        guard let baseGameScene = BaseGameScene(fileNamed: "BaseGameScene") else {
            fatalError()
        }
        self.baseGameScene = baseGameScene
        self.baseGameScene.delegate = self.baseGameScene
        self.nodes = []
//        self.entityNodeMap = []
        self.baseGameScene.gameScene = self
    }

    // Setup function that is called by physics system
    public func setup(entityPhysicsMap: [Entity: PhysicsDetails]) {
        
    }

    public func addChild(_ childToAdd: Node) {
        baseGameScene.addChild(childToAdd.node)
    }

    public func removeChildren(in nodeArray: [Node]) {
        baseGameScene.removeChildren(in: nodeArray.map({ $0.node }))
    }

    func getPhysicsBody(for skPhysicsBody: SKPhysicsBody) -> PhysicsBody {
        
    }
}


