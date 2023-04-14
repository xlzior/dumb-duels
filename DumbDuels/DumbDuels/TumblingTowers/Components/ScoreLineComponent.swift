//
//  ScoreLineComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

class ScoreLineComponent: Component {
    var id: ComponentID
    var playerId: EntityID

    init(playerId: EntityID) {
        self.id = ComponentID()
        self.playerId = playerId
    }
}
