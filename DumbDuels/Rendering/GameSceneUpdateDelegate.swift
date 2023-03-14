//
//  GameSceneUpdateDelegate.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

protocol GameSceneUpdateDelegate {
    func didSceneGetPresented()
    func update(for time: Double)
    func didSceneFinishUpdate()
    func didContactBeginBetween(bodyA: PhysicsBody, bodyB: PhysicsBody)
    func didContactEndBetween(bodyA: PhysicsBody, bodyB: PhysicsBody)
}
