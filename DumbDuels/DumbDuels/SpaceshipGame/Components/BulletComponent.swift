//
//  BulletComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import Foundation
import DuelKit

class BulletComponent: Component {
    var id: ComponentID
    var playerId: EntityID

    init(for playerId: EntityID) {
        self.id = ComponentID()
        self.playerId = playerId
    }
}
