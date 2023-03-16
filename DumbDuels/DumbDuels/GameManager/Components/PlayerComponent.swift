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
}

extension PlayerComponent {
    enum State {
        case holdingAxe
        case notHoldingAxe
    }
}
