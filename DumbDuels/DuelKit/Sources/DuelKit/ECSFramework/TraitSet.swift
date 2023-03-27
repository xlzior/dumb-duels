//
//  TraitSet.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

public struct TraitSet {
    let requiredComponents: Set<ComponentTypeID>
    let excludedComponents: Set<ComponentTypeID>

    init(requiredComponents: [Component.Type], excludedComponents: [Component.Type]) {
        let requiredComponents = Set<ComponentTypeID>(requiredComponents.map { $0.typeId })
        let excludedComponents = Set<ComponentTypeID>(excludedComponents.map { $0.typeId })

        assert(TraitSet.isValid(requiredComponents: requiredComponents,
                                excludedComponents: excludedComponents),
               "Trait set is invalid. Required: \(requiredComponents). Excluded: \(excludedComponents)")

        self.requiredComponents = requiredComponents
        self.excludedComponents = excludedComponents
    }

    func isMatch(components: Set<ComponentTypeID>) -> Bool {
        hasAllRequired(components) && hasNoneExcluded(components)
    }

    private func hasAllRequired(_ components: Set<ComponentTypeID>) -> Bool {
        requiredComponents.isSubset(of: components)
    }

    private func hasNoneExcluded(_ components: Set<ComponentTypeID>) -> Bool {
        excludedComponents.isDisjoint(with: components)
    }

    static func isValid(requiredComponents: Set<ComponentTypeID>,
                        excludedComponents: Set<ComponentTypeID>) -> Bool {
        !requiredComponents.isEmpty && requiredComponents.isDisjoint(with: excludedComponents)
    }
}

extension TraitSet: Equatable {}
extension TraitSet: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine([requiredComponents, excludedComponents])
    }
}

extension TraitSet: CustomDebugStringConvertible {
    public var debugDescription: String {
        "TraitSet - required:\(requiredComponents.debugDescription) excluded: \(excludedComponents.debugDescription)"
    }
}
