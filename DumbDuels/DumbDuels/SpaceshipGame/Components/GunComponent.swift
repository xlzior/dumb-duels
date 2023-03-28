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
    var numBulletsLeft = SpaceshipConstants.numBullets
    var lastFired: Date?

    init() {
        self.id = ComponentID()
        self.lastFired = nil
    }
}
