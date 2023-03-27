//
//  SpaceshipComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import DuelKit

class SpaceshipComponent: Component {
    var id: ComponentID
    var index: Int

    init(index: Int) {
        self.id = ComponentID()
        self.index = index
    }
}
