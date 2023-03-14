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
    
    // TODO
    func canBecomeMember(_ entity: Entity, ofFamilyWithTraits traits: TraitSet) -> Bool {
        false
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
    
}
