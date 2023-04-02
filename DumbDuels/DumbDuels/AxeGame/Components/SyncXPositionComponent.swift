//
//  SyncXPositionComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 20/3/23.
//

import DuelKit

class SyncXPositionComponent: Component {
    var id: ComponentID
    var syncFrom: EntityID
    var offset: Double

    init(syncFrom: EntityID, offset: Double = 0.0) {
        self.id = ComponentID()
        self.syncFrom = syncFrom
        self.offset = offset
    }
}
