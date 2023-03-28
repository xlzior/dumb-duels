//
//  PlayerPlatformSyncSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 20/3/23.
//

import Foundation
import DuelKit

// TODO: Rename this to PlatformSyncSystem
class PlayerPlatformSyncSystem: System {
    unowned var entityManager: EntityManager

    private var player: Assemblage3<PlayerComponent, PositionComponent, SyncXPositionComponent>
    private var axe: Assemblage3<AxeComponent, PositionComponent, SyncXPositionComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.player = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PositionComponent.self, SyncXPositionComponent.self)
        self.axe = entityManager.assemblage(
            requiredComponents: AxeComponent.self, PositionComponent.self, SyncXPositionComponent.self)
    }

    func update() {
        for (_, positionComponent, syncComponent) in player {
            guard let syncFrom: PositionComponent = entityManager.getComponent(for: syncComponent.syncFrom) else {
                return
            }
            positionComponent.position.x = syncFrom.position.x
        }
        for (_, positionComponent, syncComponent) in axe {
            guard let syncFrom: PositionComponent = entityManager.getComponent(for: syncComponent.syncFrom) else {
                return
            }
            positionComponent.position.x = syncFrom.position.x + syncComponent.offset
        }
    }
}
