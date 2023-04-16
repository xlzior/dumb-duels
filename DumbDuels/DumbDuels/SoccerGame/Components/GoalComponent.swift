//
//  GoalComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import DuelKit

class GoalComponent: Component {
    var id: ComponentID
    var attackerId: EntityID

    init(attackerId: EntityID) {
        self.id = ComponentID()
        self.attackerId = attackerId
    }
}
