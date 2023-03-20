//
//  SyncXPositionComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 20/3/23.
//

import Foundation

class SyncXPositionComponent: Component {
    var id: ComponentID
    var entityToSync: EntityID

    init(entityToSync: EntityID) {
        self.id = ComponentID()
        self.entityToSync = entityToSync
    }
}
