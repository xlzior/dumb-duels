//
//  PlayerComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import DuelKit

class PlayerComponent: Component {
    var id: ComponentID
    var idx: Int

    init(idx: Int) {
        self.id = ComponentID()
        self.idx = idx
    }
}
