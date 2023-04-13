//
//  ScoreLineComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

class ScoreLineComponent: Component {
    var id: ComponentID
    var canIncreaseScore: Bool

    init(canIncreaseScore: Bool = true) {
        self.id = ComponentID()
        self.canIncreaseScore = canIncreaseScore
    }
}
