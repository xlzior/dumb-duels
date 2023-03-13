//
//  EntityManager.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation
final class EntityManager {
    
    final var componentsByType: [ComponentTypeID: [ComponentID : Component]]
    
    final var entityComponentMap: [EntityID: Set<Pair<ComponentTypeID, ComponentID>>]
    
    final var assemblageEntityMap: [TraitSet: Set<EntityID>]
    
    convenience init() {
        self.init(componentsByType: [:], entityComponentMap: [:], assemblageEntityMap: [:])
    }
    
    internal init(componentsByType: [ComponentTypeID: [ComponentID : Component]],
                  entityComponentMap: [EntityID: Set<Pair<ComponentTypeID, ComponentID>>],
                  assemblageEntityMap: [TraitSet: Set<EntityID>]) {
        self.componentsByType = componentsByType
        self.entityComponentMap = entityComponentMap
        self.assemblageEntityMap = assemblageEntityMap
    }
    
    deinit {
        clear()
    }
    
    final func clear() {
        componentsByType.removeAll()
        entityComponentMap.removeAll()
        assemblageEntityMap.removeAll()
    }
}
