//
//  PositionSyncSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 20/3/23.
//

import Foundation
import DuelKit

class PositionSyncSystem: System {
    unowned var entityManager: EntityManager

    private var follower: Assemblage2<PositionComponent, SyncXPositionComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.follower = entityManager.assemblage(
            requiredComponents: PositionComponent.self, SyncXPositionComponent.self)
    }

    func update() {
        for (positionComponent, syncComponent) in follower {
            guard let syncFrom: PositionComponent = entityManager.getComponent(for: syncComponent.syncFrom) else {
                return
            }
            positionComponent.position.x = syncFrom.position.x + syncComponent.offset
        }
    }
}
