//
//  PlatformCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct PlatformCategory: CollisionCategory {

    var entityId: EntityID

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
        nil
    }

    func collides(with peg: PegCategory) -> Event? {
        nil
    }
}
