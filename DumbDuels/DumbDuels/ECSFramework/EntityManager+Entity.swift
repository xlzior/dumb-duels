//
//  EntityManager+Entity.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

extension EntityManager {
    @discardableResult
    func createEntity() -> Entity {
        let entityId = nextEntityId()
        entityComponentMap[entityId] = []
        return Entity(id: entityId)
    }
    
    // Not sure if needed
//    @discardableResult
//    public func createEntity(with components: Component...) -> Entity {
//        let newEntity = createEntity()
//        assign(components: components, to: newEntity.id)
//        return newEntity
//    }
    
    @discardableResult
    func createEntity<C>(with components: C) -> Entity where C: Collection, C.Element == Component {
        let newEntity = createEntity()
        assign(components: components, to: newEntity.id)
        return newEntity
    }
    
    var numEntities: Int {
        entityComponentMap.keys.count
    }
    
    func destroy(entity: Entity) -> Bool {
        fatalError("not implemented")
    }
    
    func destroy(entityId: EntityID) -> Bool {
        guard entityComponentMap.keys.contains(entityId) else {
            assertionFailure("Attempt to destroy non-existent entity \(entityId)")
            return false
        }
        
        // TODO 
        removeAllComponents(for: entityId)
    }
    
    private func nextEntityId() -> EntityID {
        EntityID(UUID().uuidString)
    }
}
