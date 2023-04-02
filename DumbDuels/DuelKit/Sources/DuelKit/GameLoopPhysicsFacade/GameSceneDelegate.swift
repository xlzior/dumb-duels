//
//  GameSceneDelegate.swift
//  DuelKit
//
//  Created by Bryan Kwok on 15/3/23.
//

import Foundation

public protocol GameSceneDelegate: AnyObject {
    // Needs to take in PhysicsSystem (some init method tat Bing Sen needs)
    func gameLoopDidStart()
    func update(with timeInterval: Double)
    func didSimulatePhysics()
    func didFinishUpdate()
}
