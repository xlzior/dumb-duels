//
//  Powerup.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

protocol Powerup {
    func apply(powerupId: EntityID, to playerId: EntityID, in entityManager: EntityManager)
}
