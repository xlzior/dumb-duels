//
//  ThrowAxeEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

struct ThrowAxeEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID
    var faceDirection: FaceDirection
    var throwStrength: CGFloat = 1.0

    func execute(with systems: SystemManager) {
        guard let physicsSystem = systems.get(ofType: PhysicsSystem.self) else {
            return
        }

        physicsSystem.applyImpulse(
            faceDirection.rawValue * throwStrength * Constants.throwForce,
            to: entityId)
    }
}
