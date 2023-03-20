//
//  AxeCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct AxeCategory: CollisionCategory {
    var entityId: EntityID
    let ownBitmask: UInt32 = CollisionUtils.axeBitmask
    let collideBitmask: UInt32 = CollisionUtils.axeCollideBitmask
    let contactBitmask: UInt32 = CollisionUtils.axeContactBitmask

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
        nil
    }

    func collides(with platform: PlatformCategory) -> Event? {
        CollisionHandler.getEvent(between: self, and: platform)
    }

    func collides(with peg: PegCategory) -> Event? {
        nil
    }

    func collides(with wall: WallCategory) -> Event? {
        nil
    }
}
