//
//  CollisionHandler.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct CollisionHandler {
    static func getEvent(between player: PlayerCategory, and axe: AxeCategory) -> Event? {
        return PlayerHitEvent(entityId: player.entityId, hitBy: axe.entityId)
    }

    static func getEvent(between player: PlayerCategory, and platform: PlatformCategory) -> Event? {
        return LandEvent(entityId: player.entityId)
    }
}
