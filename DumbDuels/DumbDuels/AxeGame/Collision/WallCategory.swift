//
//  WallCategory.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 20/3/23.
//

import Foundation

struct WallCategory: CollisionCategory {

    var entityId: EntityID
    let ownBitmask: UInt32 = CollisionUtils.wallBitmask
    let collideBitmask: UInt32 = CollisionUtils.wallCollideBitmask
    let contactBitmask: UInt32 = CollisionUtils.wallContactBitmask

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
        nil
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
