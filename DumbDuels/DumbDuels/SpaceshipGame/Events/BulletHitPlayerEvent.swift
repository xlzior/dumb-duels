//
//  BulletHitPlayerEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

struct BulletHitPlayerEvent: Event {
    var priority = 2

    let bulletId: EntityID
    let playerId: EntityID

    func execute(with systems: SystemManager) {
        print("bullet hit player \(playerId)")
        // TODO: if bullet was fired by player himself, nothing happens
        // TODO: if bullet was fired by other player, this player dies, reset round
    }
}
