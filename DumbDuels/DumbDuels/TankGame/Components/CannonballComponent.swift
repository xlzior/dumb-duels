//
//  CannonballComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import Foundation
import DuelKit

class CannonballComponent: Component {
    var id: ComponentID
    var playerId: EntityID
    var immunityUntil: Date
    var expiryDate: Date

    init(expiring expiryDate: Date, firedBy playerId: EntityID, immunityUntil: Date) {
        self.id = ComponentID()
        self.expiryDate = expiryDate
        self.playerId = playerId
        self.immunityUntil = immunityUntil
    }
}
