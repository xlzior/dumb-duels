//
//  BulletComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class BulletComponent: Component {
    var id: ComponentID
    var playerId: EntityID
    var createdAt: Date
    var lifespan: TimeInterval

    var destroyTime: Date {
        createdAt.addingTimeInterval(lifespan)
    }

    init(for playerId: EntityID, lifespan: TimeInterval = SPConstants.bulletLifespan) {
        self.id = ComponentID()
        self.playerId = playerId
        self.createdAt = Date()
        self.lifespan = lifespan
    }
}
