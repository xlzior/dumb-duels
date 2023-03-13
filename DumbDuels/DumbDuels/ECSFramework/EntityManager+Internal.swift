//
//  EntityManager+Internal.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

extension EntityManager {
    @discardableResult
    func createEntity() -> Entity {
        fatalError("not implemented")
    }
    
    @discardableResult
    func createEntity<C>(with components: C) -> Entity where C: Collection, C.Element == Component {
        fatalError("not implemented")
    }
    
    var numEntities: Int {
        entityComponentMap.keys.count
    }
    
    func destroy(entity: Entity) -> Bool {
        fatalError("not implemented")
    }
    
    func destroy(entityId: EntityID) -> Bool {
        fatalError("not implemented")
    }
}
