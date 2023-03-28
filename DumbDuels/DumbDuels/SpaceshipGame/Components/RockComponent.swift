//
//  RockComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import DuelKit

class RockComponent: Component {
    var id: ComponentID
    var playerId: EntityID?

    init(justActivatedBy playerId: EntityID) {
        self.id = ComponentID()
        self.playerId = playerId
    }
}
