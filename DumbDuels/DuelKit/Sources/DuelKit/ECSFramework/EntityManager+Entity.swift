//
//  EntityManager+Entity.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

public extension EntityManager {
    @discardableResult
    func createEntity() -> Entity {
        let entityId = nextEntityId()
        entityComponentMap[entityId] = []
        return Entity(id: entityId, manager: self)
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

    @discardableResult
    func destroy(entity: Entity) -> Bool {
        destroy(entityId: entity.id)
    }

    @discardableResult
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

    func makeEntitiesIterator() -> EntitiesIterator {
        EntitiesIterator(entityManager: self)
    }

    private func nextEntityId() -> EntityID {
        EntityID(UUID().uuidString)
    }
}

extension EntityManager {
    /**
     * Allows external users to loop through entities without knowing underlying implementation
     * The order of sequence is not guaranteed to stay the same for use
     */
    public struct EntitiesIterator: IteratorProtocol {
        private var iterator: AnyIterator<Entity>

        init(entityManager: EntityManager) {
            var iter = entityManager.entityComponentMap.keys.makeIterator()
            iterator = AnyIterator {
                guard let entityId = iter.next() else {
                    return nil
                }
                return Entity(id: entityId, manager: entityManager)
            }
        }

        public func next() -> Entity? {
            iterator.next()
        }
    }
}

extension EntityManager.EntitiesIterator: LazySequenceProtocol {}
extension EntityManager.EntitiesIterator: Sequence {}
