//
//  PlayerComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

class PlayerComponent: Component {
    var id: ComponentID
    // TODO: should player even store this? Or store some global variable to identify which player
    var idx: Int
    let fsm: EntityStateMachine<State>

    init(fsm: EntityStateMachine<State>, idx: Int) {
        self.id = ComponentID()
        self.fsm = fsm
        self.idx = idx
    }
}

extension PlayerComponent {
    enum State {
        case holdingAxe
        case notHoldingAxe
    }
}
