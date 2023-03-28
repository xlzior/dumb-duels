//
//  EntityManager+Internal.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

extension EntityManager {
    @discardableResult
    public func assign<C>(components: C, to entityId: EntityID) -> Bool where C: Collection, C.Element == Component {
        for component in components {
            let isSuccessfullyAssigned = assign(component: component, to: entityId)

            guard isSuccessfullyAssigned else {
                assertionFailure("\(component) was not assigned to \(entityId). All other assignments aborted.")
                return false
            }
        }

        updateAssemblageMembership(for: entityId)
        return true
    }

    @discardableResult
    public func assign(component: Component, to entityId: EntityID) -> Bool {
        let componentTypeId = component.typeId
        let componentId = component.id

        // If component exists, it must be assigned to some entity already
        // because remove(component:from) should remove the component from this map when unassigning
        // Remove this if we want to allow same component instance to be assigned to multiple entities
        guard componentsByType[componentTypeId]?[componentId] == nil else {
            assertionFailure("\(componentId) of type \(componentTypeId) is already assigned previously.")
            return false
        }

        guard !has(componentTypeId: componentTypeId, entityId: entityId) else {
            // TODO: can delete? just no-op
//            assertionFailure("\(entityId) already has component type \(componentTypeId).")
            return false
        }

        insertComponent(component, ofType: componentTypeId)
        assign(componentId, componentTypeId, entityId)
        updateAssemblageMembership(for: entityId)
        return true
    }

    func updateAssemblageMembership(for entityId: EntityID) {
        for traits in assemblageEntityMap.keys {
            update(membership: traits, for: entityId)
        }
    }

    func onAssemblageInit(traits: TraitSet) {
        guard assemblageEntityMap[traits] == nil else {
            // We do not assert fail because we allow users to define multiple assemblages
            // with same traits, but internally we store as one
            return
        }

        assemblageEntityMap[traits] = Set()
        updateEntityMemberships(forAssemblage: traits)
    }

    private func updateEntityMemberships(forAssemblage traits: TraitSet) {
        for entityId in entityComponentMap.keys {
            update(membership: traits, for: entityId)
        }
    }

    private func update(membership traits: TraitSet, for entityId: EntityID) {
        guard let componentTypeIds = getAllComponentTypes(for: entityId) else {
            return
        }

        // Is **previously** a member
        let isMember = isMember(entityId, ofAssemblageWithTraits: traits)
        if !exists(entity: entityId) && isMember {
            // Probably reached here after destroyed(entityId) is called
            remove(entityId: entityId, fromAssemblageWithTraits: traits)
            return
        }

        // Should **currently** be a member
        let isMatch = traits.isMatch(components: componentTypeIds)
        if isMatch && !isMember {
            add(entityId: entityId, toAssemblageWithTraits: traits)
        } else if !isMatch && isMember {
            remove(entityId: entityId, fromAssemblageWithTraits: traits)
        }
    }

    // Only inserts component to the list of all components
    // Does not include adding component into the entity-to-component map or updating assemblage memberships
    private func insertComponent(_ component: Component, ofType: ComponentTypeID) {
        let componentTypeId = component.typeId
        let componentId = component.id
        if componentsByType[componentTypeId] == nil {
            componentsByType[componentTypeId] = [ComponentID: Component]()
        }
        componentsByType[componentTypeId]![componentId] = component
    }

    // Only inserts component type id and instance id into the entity-to-component map
    // Does not include updating assemblage membership or adding component to the list of all components
    private func assign(_ componentId: ComponentID, _ componentTypeId: ComponentTypeID, _ entityId: EntityID) {
        let componentIdAndTypeId = Pair(first: componentTypeId, second: componentId)

        let isSuccess = entityComponentMap[entityId]?.insert(componentIdAndTypeId)

        // Key not found in entityComponentMap
        if isSuccess == nil {
            assertionFailure("Entity \(entityId) does not exist when assigning component")
        }
    }

    // Pre-condition: Caller must ensure that assemblageEntityMap has key "traits"
    // Only assigns the entityId to the assemblage-to-entity map without any checks
    // Checks should be done by caller
    private func add(entityId: EntityID, toAssemblageWithTraits traits: TraitSet) {
        assemblageEntityMap[traits]?.insert(entityId)
    }

    // Pre-condition: Caller must ensure that assemblageEntityMap has key "traits"
    // Only assigns the entityId to the assemblage-to-entity map without any checks
    // Checks should be done by caller
    private func remove(entityId: EntityID, fromAssemblageWithTraits traits: TraitSet) {
        assemblageEntityMap[traits]?.remove(entityId)
    }
}
