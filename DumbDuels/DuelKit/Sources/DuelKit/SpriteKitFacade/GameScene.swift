//
//  GameScene.swift
//  DuelKit
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

class GameScene: Scene {
    private(set) var baseGameScene: BaseGameScene
    private var bodyIDPhysicsMap: [EntityID: PhysicsBody]
    private var skNodebodyIDMap: [SKNode: EntityID]

    var gameSceneDelegate: GameSceneDelegate? {
        get { baseGameScene.gameSceneDelegate }
        set { baseGameScene.gameSceneDelegate = newValue }
    }

    var physicsContactDelegate: PhysicsContactDelegate? {
        get { baseGameScene.physicsContactDelegate }
        set { baseGameScene.physicsContactDelegate = newValue }
    }

    init() {
        self.baseGameScene = BaseGameScene(size: Sizes.game)
        self.baseGameScene.delegate = self.baseGameScene
        self.bodyIDPhysicsMap = [:]
        self.skNodebodyIDMap = [:]
        self.baseGameScene.gameScene = self
    }

    func forEachEntity(perform action: (EntityID, PhysicsSimulatableBody) -> Void) {
        for (id, physicsBody) in bodyIDPhysicsMap {
            action(id, physicsBody)
        }
    }

    func createCirclePhysicsSimulatableBody(for id: EntityID,
                                            withRadius radius: CGFloat,
                                            at position: CGPoint) -> PhysicsSimulatableBody {
        let newPhysicsBody = PhysicsBody(circleOf: radius, at: position)
        addBody(for: id, bodyToAdd: newPhysicsBody)
        return newPhysicsBody
    }

    func createRectanglePhysicsSimulatableBody(for id: EntityID,
                                               withSize size: CGSize,
                                               at position: CGPoint) -> PhysicsSimulatableBody {
        let newPhysicsBody = PhysicsBody(rectangleOf: size, at: position)
        addBody(for: id, bodyToAdd: newPhysicsBody)
        return newPhysicsBody
    }

    func removePhysicsSimulatableBody(for id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap.removeValue(forKey: id),
              skNodebodyIDMap.removeValue(forKey: physicsBody.node) != nil else {
            assertionFailure("Trying to remove an id that does not exist.")
            return
        }
        baseGameScene.removeChildren(in: [physicsBody.node])
    }

    func getPhysicsSimulatableBody(for id: EntityID) -> PhysicsSimulatableBody? {
        guard let physicsBody = bodyIDPhysicsMap[id],
              skNodebodyIDMap[physicsBody.node] != nil else {
            return nil
        }
        return physicsBody
    }

    func apply(impulse: CGVector, to id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              skNodebodyIDMap[physicsBody.node] != nil else {
            assertionFailure("Trying to apply impulse to an id that does not exist.")
            return
        }
        physicsBody.applyImpulse(impulse)
    }

    func apply(angularImpulse: CGFloat, to id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              skNodebodyIDMap[physicsBody.node] != nil else {
            assertionFailure("Trying to apply impulse to an id that does not exist.")
            return
        }
        physicsBody.applyAngularImpulse(angularImpulse)
    }

    func beginOscillation(for id: EntityID, at centerOfOscillation: CGPoint, axis: CGVector,
                          amplitude: Double, period: Double, displacement: Double) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              skNodebodyIDMap[physicsBody.node] != nil else {
            assertionFailure("Trying to start oscillation for an entity that does not exist.")
            return
        }
        let oscillate = SKAction.oscillation(centerOfOscillation: centerOfOscillation, axis: axis,
                                             amplitude: amplitude, period: period, initialDisplacement: displacement)
        physicsBody.node.run(SKAction.repeatForever(oscillate), withKey: "oscillation")
    }

    func stopOscillation(for id: EntityID) {
        guard let physicsBody = bodyIDPhysicsMap[id],
              skNodebodyIDMap[physicsBody.node] != nil else {
            assertionFailure("Trying to stop oscillation for an entity that does not exist.")
            return
        }
        physicsBody.node.removeAction(forKey: "oscillation")
    }

    func addBody(for id: EntityID, bodyToAdd: PhysicsBody) {
        guard bodyIDPhysicsMap[id] == nil,
              skNodebodyIDMap[bodyToAdd.node] == nil else {
            assertionFailure("Trying to add an id that already exists.")
            return
        }
        baseGameScene.addChild(bodyToAdd.node)
        bodyIDPhysicsMap[id] = bodyToAdd
        skNodebodyIDMap[bodyToAdd.node] = id
    }

    func getEntityID(for skPhysicsBody: SKPhysicsBody) -> EntityID? {
        if let skNode = skPhysicsBody.node,
           let entityID = skNodebodyIDMap[skNode] {
            return entityID
        }
        assertionFailure("Could not find corresponding BodyID for SKPhysicsBody")
        return nil
    }
}
