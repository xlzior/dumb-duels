//
//  GameScene.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

public typealias EntityID = String

public class GameScene {
    var baseGameScene: BaseGameScene
    var entityPhysicsMap: [EntityID: PhysicsBody]

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
            fatalError("BaseGameScene failed to load.")
        }
        self.baseGameScene = baseGameScene
        self.baseGameScene.delegate = self.baseGameScene
        self.entityPhysicsMap = [:]
        self.baseGameScene.gameScene = self
    }

    public func setup(entityPhysicsMap: [EntityID: PhysicsBody]) {
        self.entityPhysicsMap = entityPhysicsMap
        for (_, physicsBody) in entityPhysicsMap {
            baseGameScene.addChild(physicsBody.node)
        }
    }

    public func addBody(for entity: EntityID, bodyToAdd: PhysicsBody) {
        baseGameScene.addChild(bodyToAdd.node)
        entityPhysicsMap[entity] = bodyToAdd
    }

    public func removeBody(for entity: EntityID) {
        let physicsBody = entityPhysicsMap.removeValue(forKey: entity)
        if let physicsBody = physicsBody {
            baseGameScene.removeChildren(in: [physicsBody.node])
        }
    }

    func getPhysicsBody(for skPhysicsBody: SKPhysicsBody) -> PhysicsBody? {
        for (_, physicsBody) in entityPhysicsMap {
            if let nodeSkPhysicsBody = physicsBody.node.physicsBody, nodeSkPhysicsBody == skPhysicsBody {
                return physicsBody
            }
        }
        assertionFailure("Could not find corresponding PhysicsBody for SKPhysicsBody")
        return nil
    }

    func apply(impulse: CGVector, to entity: EntityID) {
        entityPhysicsMap[entity]?.applyImpulse(impulse)
    }

    public func sync(entityPhysicsMap: [EntityID: PhysicsBody]) {
        for (entity, physicsBody) in entityPhysicsMap {
            self.entityPhysicsMap[entity]?.updateWith(newPhysicsBody: physicsBody)
        }
    }
}
