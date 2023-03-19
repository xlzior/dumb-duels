//
//  CollisionSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

class CollisionSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
    }

    func update() {

    }

    func handleCollision(firstId: String, secondId: String) {
        let firstEid = EntityID(firstId)
        let secondEid = EntityID(secondId)
        guard let firstCollider: CollidableComponent = entityManager.getComponent(ofType: CollidableComponent.typeId, for: firstEid),
              let secondCollider: CollidableComponent = entityManager.getComponent(ofType: CollidableComponent.typeId, for: secondEid) else {
            return
        }
        for firstCategory in firstCollider.categories {
            for secondCategory in secondCollider.categories {
                if let collisionEvent = firstCategory.collides(with: secondCategory) {
                    eventFirer.fire(collisionEvent)
                }
            }
        }
    }
}