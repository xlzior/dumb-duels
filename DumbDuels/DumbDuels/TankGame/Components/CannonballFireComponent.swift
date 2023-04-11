//
//  CannonballFireComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 11/4/23.
//

import DuelKit

class CannonballFireComponent: Component {
    var id: ComponentID
    var ballId: EntityID

    init(ballId: EntityID) {
        self.id = ComponentID()
        self.ballId = ballId
    }
}
