//
//  SoccerPlayerComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import DuelKit

class SoccerPlayerComponent: Component {
    var id: ComponentID
    var index: Int
    var isMoving: Bool

    init(index: Int) {
        self.id = ComponentID()
        self.index = index
        self.isMoving = false
    }
}
