//
//  PlayerComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

class PlayerComponent: Component {
    var id: ComponentID
    let fsm: EntityStateMachine<State>

    init(fsm: EntityStateMachine<State>) {
        self.id = ComponentID()
        self.fsm = fsm
    }
    
    // TODO: FSM implementation
    // when state changed to holding Axe
    // add a HoldingAxe component
}

extension PlayerComponent {
    enum State {
        case holdingAxe
        case notHoldingAxe
    }
}
