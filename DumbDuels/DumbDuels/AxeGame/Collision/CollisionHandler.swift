//
//  CollisionHandler.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct CollisionHandler {
    static func getEvent(between player: PlayerCategory, and axe: AxeCategory) -> Event? {
        print("Contact handler player: \(player.entityId), axe: \(axe.entityId)")
        return PlayerHitEvent(entityId: player.entityId, hitBy: axe.entityId)
    }

    static func getEvent(between player: PlayerCategory, and platform: PlatformCategory) -> Event? {
        print("Contact handler player: \(player.entityId), platform: \(platform.entityId)")
        return LandEvent(entityId: player.entityId)
    }
}
