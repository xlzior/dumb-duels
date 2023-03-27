//
//  PhysicsContactDelegate.swift
//  DuelKit
//
//  Created by Bryan Kwok on 15/3/23.
//

import Foundation

public protocol PhysicsContactDelegate: AnyObject {
    func didContactBegin(for entityA: EntityID, and entityB: EntityID)
    func didContactEnd(for entityA: EntityID, and entityB: EntityID)
}
