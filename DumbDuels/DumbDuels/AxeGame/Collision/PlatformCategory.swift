//
//  PlatformCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct PlatformCategory: CollisionCategory {

    var entityId: EntityID
    let ownBitmask: UInt32 = CollisionUtils.platformBitmask
    let collideBitmask: UInt32 = CollisionUtils.platformCollideBitmask
    let contactBitmask: UInt32 = CollisionUtils.platformContactBitmask

    init(entityId: EntityID) {
        self.entityId = entityId
    }

    func collides(with otherCategory: CollisionCategory) -> Event? {
        otherCategory.collides(with: self)
    }

    func collides(with player: PlayerCategory) -> Event? {
        CollisionHandler.getEvent(between: player, and: self)
    }

    func collides(with axe: AxeCategory) -> Event? {
        CollisionHandler.getEvent(between: axe, and: self)
    }

    func collides(with platform: PlatformCategory) -> Event? {
        nil
    }

    func collides(with peg: PegCategory) -> Event? {
        nil
    }

    func collides(with wall: WallCategory) -> Event? {
        nil
    }
}
