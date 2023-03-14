//
//  EntityManager+Assemblage.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 14/3/23.
//

import Foundation


extension EntityManager {
    var numAssemblages: Int {
        assemblageEntityMap.keys.count
    }

    func canBecomeMember(_ entity: Entity, ofFamilyWithTraits traits: TraitSet) -> Bool {
        guard let componentTypeIds = getAllComponentTypes(for: entity.id) else {
            assertionFailure("Test canBecomeMember failure: Entity \(entity.id) does not exist")
            return false
        }
        return traits.isMatch(components: componentTypeIds)
    }
    
    func members(withTraits traits: TraitSet) -> Set<EntityID> {
        assemblageEntityMap[traits] ?? Set()
    }
    
    func isMember(_ entity: Entity, ofFamilyWithTraits traits: TraitSet) -> Bool {
        isMember(entity.id, ofFamilyWithTraits: traits)
    }
    
    func isMember(_ entityId: EntityID, ofFamilyWithTraits traits: TraitSet) -> Bool {
        members(withTraits: traits).contains(entityId)
    }
    
    // TODO: If needed, this can be moved into Assemblage file
    func createMember<R>(with components: R.Components, for assemblage: Assemblage<R>) -> Entity
        where R: AssemblageRequirementsManager {
            R.createMember(entityManager: self, components: components)
    }
}
