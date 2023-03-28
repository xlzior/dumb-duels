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

    init(ofType powerup: any Powerup) {
        self.id = ComponentID()
        self.powerup = powerup
    }
}
