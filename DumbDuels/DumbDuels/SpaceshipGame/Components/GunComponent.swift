//
//  GunComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class GunComponent: Component {
    var id: ComponentID
    var numBulletsLeft = SPConstants.numBullets
    var lastFired: Date?
    var gunInterval: TimeInterval

    init(numBulletsLeft: Int = SPConstants.numBullets,
         gunInterval: TimeInterval = SPConstants.gunInterval) {
        self.id = ComponentID()
        self.lastFired = nil
        self.numBulletsLeft = numBulletsLeft
        self.gunInterval = gunInterval
    }
}
