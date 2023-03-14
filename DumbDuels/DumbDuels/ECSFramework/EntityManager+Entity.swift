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
    
    // Needed for Assemblage generated file
    @discardableResult
    func createEntity(with components: Component...) -> Entity {
        let newEntity = createEntity()
        assign(components: components, to: newEntity.id)
        return newEntity
    }
    
    @discardableResult
    func createEntity<C>(with components: C) -> Entity where C: Collection, C.Element == Component {
        let newEntity = createEntity()
        assign(components: components, to: newEntity.id)
        return newEntity
    }
    
    var numEntities: Int {
        entityComponentMap.keys.count
    }
    
    func exists(entity entityId: EntityID) -> Bool {
        entityComponentMap.keys.contains(entityId)
    }

    func destroy(entity: Entity) -> Bool {
        destroy(entityId: entity.id)
    }
    
    func destroy(entityId: EntityID) -> Bool {
        guard entityComponentMap.keys.contains(entityId) else {
            assertionFailure("Attempt to destroy non-existent entity \(entityId)")
            return false
        }
        
        // Assemblage memeberships will be updated in this function as well
        removeAllComponents(for: entityId)
        
        entityComponentMap.removeValue(forKey: entityId)
        return true
    }
    
    private func nextEntityId() -> EntityID {
        EntityID(UUID().uuidString)
    }
}

extension EntityManager {
    /**
     * Allows external users to loop through entities without knowing underlying implementation (i.e. without using entityComponentsMap.keys)
     * The order of sequence is not guaranteed to stay the same for use
     */
    struct EntitiesIterator: IteratorProtocol {
        private var iterator: AnyIterator<Entity>
        
        init(entityManager: EntityManager) {
            var iter = entityManager.entityComponentMap.keys.makeIterator()
            iterator = AnyIterator {
                guard let entityId = iter.next() else {
                    return nil
                }
                return Entity(id: entityId)
            }
        }
        
        func next() -> Entity? {
            iterator.next()
        }
    }
}

extension EntityManager.EntitiesIterator: LazySequenceProtocol {}
extension EntityManager.EntitiesIterator: Sequence {}
