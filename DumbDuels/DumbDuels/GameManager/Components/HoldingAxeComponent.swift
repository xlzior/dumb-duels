//
//  HoldingAxeComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

class HoldingAxeComponent: Component {
    var id: ComponentID
    var axeEntityID: EntityID
    
    init(axeEntityID: EntityID) {
        self.id = ComponentID()
        self.axeEntityID = axeEntityID
    }
}
