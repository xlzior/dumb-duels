//
//  CollisionCategory.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

protocol CollisionCategory {
    var entityId: EntityID { get }
    func collides(with otherCategory: any CollisionCategory) -> Event?
    func collides(with player: PlayerCategory) -> Event?
    func collides(with axe: AxeCategory) -> Event?
    func collides(with platform: PlatformCategory) -> Event?
    func collides(with peg: PegCategory) -> Event?
}
