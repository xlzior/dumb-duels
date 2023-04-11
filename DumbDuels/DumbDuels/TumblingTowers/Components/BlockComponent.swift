//
//  BlockComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import DuelKit

class BlockComponent: Component {
    var id: ComponentID
    var playerId: EntityID

    init(playerId: EntityID) {
        self.id = ComponentID()
        self.playerId = playerId
    }
}
