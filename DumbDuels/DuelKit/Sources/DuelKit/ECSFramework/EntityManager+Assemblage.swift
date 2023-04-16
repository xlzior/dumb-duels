//
//  EntityManager+Assemblage.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 14/3/23.
//

import Foundation

extension EntityManager {
    var numAssemblages: Int {
        assemblageEntityMap.keys.count
    }

    func canBecomeMember(_ entity: Entity, ofAssemblageWithTraits traits: TraitSet) -> Bool {
        guard let componentTypeIds = getAllComponentTypes(for: entity.id) else {
            assertionFailure("Test canBecomeMember failure: Entity \(entity.id) does not exist")
            return false
        }
        return traits.isMatch(components: componentTypeIds)
    }

    func members(withTraits traits: TraitSet) -> Set<EntityID> {
        assemblageEntityMap[traits] ?? Set()
    }

    func isMember(_ entity: Entity, ofAssemblageWithTraits traits: TraitSet) -> Bool {
        isMember(entity.id, ofAssemblageWithTraits: traits)
    }

    func isMember(_ entityId: EntityID, ofAssemblageWithTraits traits: TraitSet) -> Bool {
        members(withTraits: traits).contains(entityId)
    }

    func createMember<R>(with components: R.Components, for assemblage: Assemblage<R>) -> Entity
        where R: AssemblageRequirementsManager {
            R.createMember(entityManager: self, components: components)
    }
}
