//
//  CanJumpComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class CanJumpComponent: Component {
    var id: ComponentID

    var jumpsLeft: Int

    init(jumpsLeft: Int = 2) {
        self.jumpsLeft = jumpsLeft
        self.id = ComponentID()
    }
}
