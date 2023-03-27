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

    init(syncFrom: EntityID) {
        self.id = ComponentID()
        self.syncFrom = syncFrom
    }
}
