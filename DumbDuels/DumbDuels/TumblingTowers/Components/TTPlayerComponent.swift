//
//  PlayerComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

class TTPlayerComponent: Component {
    var id: ComponentID
    var index: Int
    var currentControllingBlockId: EntityID?
    // The alternating direction to move the block
    var moveDirection: Int

    init(index: Int, moveDirection: Int = 1) {
        self.id = ComponentID()
        self.index = index
        self.currentControllingBlockId = nil
        self.moveDirection = moveDirection
    }
}
