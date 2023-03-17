//
//  PlayerCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

struct PlayerCategory: CollisionCategory {

    var entityId: EntityID

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
