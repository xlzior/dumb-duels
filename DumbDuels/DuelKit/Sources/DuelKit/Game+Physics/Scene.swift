//
//  Scene.swift
//  
//
//  Created by Bryan Kwok on 27/3/23.
//

import Foundation

public protocol Scene {
    var gameSceneDelegate: GameSceneDelegate? { get set }
    var physicsContactDelegate: PhysicsContactDelegate? { get set }
    func forEachEntity(perform action: (_ id: EntityID,
                                        _ physicsSimulatableBody: PhysicsSimulatableBody) -> Void)
    func createCirclePhysicsSimulatableBody(for id: EntityID,
                                            withRadius radius: CGFloat,
                                            at position: CGPoint) -> PhysicsSimulatableBody
    func createRectanglePhysicsSimulatableBody(for id: EntityID,
                                               withSize size: CGSize,
                                               at position: CGPoint) -> PhysicsSimulatableBody
    func removePhysicsSimulatableBody(for id: EntityID)
    func getPhysicsSimulatableBody(for id: EntityID) -> PhysicsSimulatableBody?
    func apply(impulse: CGVector, to id: EntityID)
    func apply(angularImpulse: CGFloat, to id: EntityID)
    func beginOscillation(for id: EntityID, at centerOfOscillation: CGPoint, axis: CGVector,
                          amplitude: Double, period: Double, displacement: Double)
    func stopOscillation(for id: EntityID)
}
