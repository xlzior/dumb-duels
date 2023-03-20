//
//  CollisionCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

protocol CollisionCategory {
    var entityId: EntityID { get }
    var ownBitmask: UInt32 { get }
    var collideBitmask: UInt32 { get }
    var contactBitmask: UInt32 { get }

    func collides(with otherCategory: any CollisionCategory) -> Event?
    func collides(with player: PlayerCategory) -> Event?
    func collides(with axe: AxeCategory) -> Event?
    func collides(with platform: PlatformCategory) -> Event?
    func collides(with peg: PegCategory) -> Event?
    func collides(with wall: WallCategory) -> Event?
}
