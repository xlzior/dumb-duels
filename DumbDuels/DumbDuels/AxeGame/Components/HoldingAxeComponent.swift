//
//  HoldingAxeComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import DuelKit

class HoldingAxeComponent: ComponentInitializable {
    var id: ComponentID
    var axeEntityID: EntityID

    init(axeEntityID: EntityID) {
        self.id = ComponentID()
        self.axeEntityID = axeEntityID
    }

    required init() {
        self.id = ComponentID()
        self.axeEntityID = EntityID()
    }
}
