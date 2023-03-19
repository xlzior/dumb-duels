//
//  PlayerCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct PlayerCategory: CollisionCategory {
    var entityId: EntityID
    let ownBitmask: UInt32 = CollisionUtils.playerBitmask
    let collideBitmask: UInt32 = CollisionUtils.playerCollideBitmask
    let contactBitmask: UInt32 = CollisionUtils.playerContactBitmask

    init(entityId: EntityID) {
        self.entityId = entityId
    }

    func collides(with otherCategory: CollisionCategory) -> Event? {
        otherCategory.collides(with: self)
    }

    func collides(with player: PlayerCategory) -> Event? {
        nil
    }

    func collides(with axe: AxeCategory) -> Event? {
        CollisionHandler.getEvent(between: self, and: axe)
    }

    func collides(with platform: PlatformCategory) -> Event? {
        CollisionHandler.getEvent(between: self, and: platform)
    }

    func collides(with peg: PegCategory) -> Event? {
        nil
    }
}
