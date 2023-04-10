//
//  ThrowStrengthComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 23/3/23.
//

import DuelKit

class ThrowStrengthComponent: Component {
    var id: ComponentID
    var throwStrength = AXConstants.defaultThrowStrength
    let fsm: EntityStateMachine<State>

    init(fsm: EntityStateMachine<State>) {
        self.id = ComponentID()
        self.fsm = fsm
    }
}

extension ThrowStrengthComponent {
    enum State {
        case charging
        case notCharging
    }
}
