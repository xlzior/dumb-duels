//
//  PowerupComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

class PowerupComponent: Component {
    var id: ComponentID
    var powerup: any Powerup
    var isActivated: Bool

    init(ofType powerup: any Powerup, isActivated: Bool = false) {
        self.id = ComponentID()
        self.powerup = powerup
        self.isActivated = isActivated
    }
}
