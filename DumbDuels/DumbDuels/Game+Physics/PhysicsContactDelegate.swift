//
//  PhysicsContactDelegate.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 15/3/23.
//

import Foundation

public protocol PhysicsContactDelegate: AnyObject {
    func didContactBegin(for bodyA: PhysicsBody, and bodyB: PhysicsBody)
    func didContactEnd(for bodyA: PhysicsBody, and bodyB: PhysicsBody)
}
