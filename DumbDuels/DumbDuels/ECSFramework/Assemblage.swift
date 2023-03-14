//
//  Assemblage.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation
// TODO for wenjun: After stencils generated, make sure this warning goes away as buildBlock is implemented
#if swift(<5.4)
enum AssemblageMemberBuilder<R> where R: AssemblageRequirementsManager {}
#else
@resultBuilder
enum AssemblageMemberBuilder<R> where R: AssemblageRequirementsManager {}
#endif

struct Assemblage<R> where R: AssemblageRequirementsManager {
    let traits: TraitSet
    
    init(entityManager: EntityManager,
         requiredComponents: @autoclosure () -> R.ComponentTypes,
         excludedComponents: [Component.Type]) {
        let required = R(requiredComponents())
        let traits = TraitSet(requiredComponents: required.componentTypes, excludedComponents: excludedComponents)
        self.traits = traits
        entityManager.onAssemblageInit(traits: traits)
    }
}
