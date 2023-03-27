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
    var bodyIDPhysicsMap: [BodyID: PhysicsBody] { get } // to remove
    func setup(newBodyIDPhysicsMap: [BodyID: PhysicsBody])
    func addBody(for id: BodyID, bodyToAdd: PhysicsBody)
    func removeBody(for id: BodyID)
    func apply(impulse: CGVector, to id: BodyID)
    func apply(angularImpulse: CGFloat, to id: BodyID)
    func sync(_ newPhysicsBody: PhysicsBody, for id: BodyID)
}
