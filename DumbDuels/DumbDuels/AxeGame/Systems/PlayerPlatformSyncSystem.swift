//
//  PlayerPlatformSyncSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 20/3/23.
//

import Foundation

class PlayerPlatformSyncSystem: System {
    unowned var entityManager: EntityManager

    private var player: Assemblage3<PlayerComponent, PositionComponent, SyncXPositionComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.player = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PositionComponent.self, SyncXPositionComponent.self)
    }

    func update() {
        for (_, positionComponent, syncComponent) in player {
            guard let syncFrom: PositionComponent = entityManager.getComponent(for: syncComponent.syncFrom) else {
                return
            }
            positionComponent.position.x = syncFrom.position.x
        }
    }
}