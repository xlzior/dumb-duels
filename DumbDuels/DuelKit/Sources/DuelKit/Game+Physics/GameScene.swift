//
//  GameScene.swift
//  DuelKit
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

// typealias BodyID = EntityID

public class GameScene: Scene {
    private(set) var baseGameScene: BaseGameScene
    private var bodyIDPhysicsMap: [EntityID: PhysicsBody]
    private var physicsBodyIDMap: [PhysicsBody: EntityID]
    private var skNodePhysicsBodyMap: [SKNode: PhysicsBody]

    public var gameSceneDelegate: GameSceneDelegate? {
        get { baseGameScene.gameSceneDelegate }
        set { baseGameScene.gameSceneDelegate = newValue }
    }

    public var physicsContactDelegate: PhysicsContactDelegate? {
        get { baseGameScene.physicsContactDelegate }
        set { baseGameScene.physicsContactDelegate = newValue }
    }

    public init() {
        self.baseGameScene = BaseGameScene(size: Sizes.game)
        self.baseGameScene.delegate = self.baseGameScene
        self.bodyIDPhysicsMap = [:]
        self.physicsBodyIDMap = [:]
        self.skNodePhysicsBodyMap = [:]
        self.baseGameScene.gameScene = self
    }

    public func forEachEntity(perform action: (EntityID, PhysicsSimulatableBody) -> Void) {
        for (id, physicsBody) in bodyIDPhysicsMap {
            action(id, physicsBody)
        }
    }

    public func createCirclePhysicsSimulatableBody(for id: EntityID,
                                                   withRadius radius: CGFloat,
                                                   at position: CGPoint) -> PhysicsSimulatableBody {
        let newPhysicsBody = PhysicsBody(circleOf: radius, at: position)
        addBody(for: id, bodyToAdd: newPhysicsBody)
        return newPhysicsBody
    }

    public func createRectanglePhysicsSimulatableBody(for id: EntityID,
                                                      withSize size: CGSize,
                                                      at position: CGPoint) -> PhysicsSimulatableBody {
        let newPhysicsBody = PhysicsBody(rectangleOf: size, at: position)
        addBody(for: id, bodyToAdd: newPhysicsBody)
        return newPhysicsBody
    }

    public func removePhysicsSimulatableBody(for id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap.removeValue(forKey: id),
              physicsBodyIDMap.removeValue(forKey: physicsBody) != nil,
              skNodePhysicsBodyMap.removeValue(forKey: physicsBody.node) != nil else {
            assertionFailure("Trying to remove an id that does not exist.")
            return
        }
        baseGameScene.removeChildren(in: [physicsBody.node])
    }

    public func getPhysicsSimulatableBody(for id: EntityID) -> PhysicsSimulatableBody? {
        guard let physicsBody = bodyIDPhysicsMap[id],
              physicsBodyIDMap[physicsBody] != nil,
              skNodePhysicsBodyMap[physicsBody.node] != nil else {
            return nil
        }
        return physicsBody
    }

    public func apply(impulse: CGVector, to id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              physicsBodyIDMap[physicsBody] != nil,
              skNodePhysicsBodyMap[physicsBody.node] != nil else {
            assertionFailure("Trying to apply impulse to an id that does not exist.")
            return
        }
        physicsBody.applyImpulse(impulse)
    }

    public func apply(angularImpulse: CGFloat, to id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              physicsBodyIDMap[physicsBody] != nil,
              skNodePhysicsBodyMap[physicsBody.node] != nil else {
            assertionFailure("Trying to apply impulse to an id that does not exist.")
            return
        }
        physicsBody.applyAngularImpulse(angularImpulse)
    }

    func addBody(for id: EntityID, bodyToAdd: PhysicsBody) {
        guard baseGameScene.nodes(at: bodyToAdd.position).isEmpty,
              bodyIDPhysicsMap[id] == nil,
              physicsBodyIDMap[bodyToAdd] == nil,
              skNodePhysicsBodyMap[bodyToAdd.node] == nil else {
            assertionFailure("Trying to add an id that already exists.")
            return
        }
        baseGameScene.addChild(bodyToAdd.node)
        bodyIDPhysicsMap[id] = bodyToAdd
        physicsBodyIDMap[bodyToAdd] = id
        skNodePhysicsBodyMap[bodyToAdd.node] = bodyToAdd
    }

    func getEntityID(for skPhysicsBody: SKPhysicsBody) -> EntityID? {
        if let skNode = skPhysicsBody.node,
           let physicsBody = skNodePhysicsBodyMap[skNode],
           let entityID = physicsBodyIDMap[physicsBody],
           bodyIDPhysicsMap[entityID] == physicsBody {
            return entityID
        }
        assertionFailure("Could not find corresponding BodyID for SKPhysicsBody")
        return nil
    }
}
