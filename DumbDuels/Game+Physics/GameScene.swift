//
//  GameScene.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

public typealias EntityID = AnyHashable

public class GameScene {
    private(set) var baseGameScene: BaseGameScene
    public private(set) var entityPhysicsMap: [EntityID: PhysicsBody]

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
        guard entityPhysicsMap[entity] == nil else {
            assertionFailure("Trying to add an entity that already exists.")
            return
        }
        baseGameScene.addChild(bodyToAdd.node)
        entityPhysicsMap[entity] = bodyToAdd
    }

    public func removeBody(for entity: EntityID) {
        guard let physicsBody = entityPhysicsMap.removeValue(forKey: entity) else {
            assertionFailure("Trying to remove an entity that does not exist.")
            return
        }
        baseGameScene.removeChildren(in: [physicsBody.node])
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
        guard entityPhysicsMap[entity] != nil else {
            assertionFailure("Trying to apply impulse to an entity that does not exist.")
            return
        }
        entityPhysicsMap[entity]?.applyImpulse(impulse)
    }

    public func sync(entityPhysicsMap: [EntityID: PhysicsBody]) {
        for (entity, physicsBody) in entityPhysicsMap {
            guard entityPhysicsMap[entity] != nil else {
                assertionFailure("Trying to sync entity that does not exist.")
                continue
            }
            self.entityPhysicsMap[entity]?.updateWith(newPhysicsBody: physicsBody)
        }
    }

    public func sync(_ physicsBody: PhysicsBody, for entity: EntityID) {
        guard entityPhysicsMap[entity] != nil else {
            assertionFailure("Trying to sync entity that does not exist.")
            return
        }
        entityPhysicsMap[entity]?.updateWith(newPhysicsBody: physicsBody)
    }
}
