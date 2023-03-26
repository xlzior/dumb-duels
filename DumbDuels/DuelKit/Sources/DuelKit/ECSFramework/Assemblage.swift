//
//  Assemblage.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

#if swift(<5.4)
public enum AssemblageMemberBuilder<R> where R: AssemblageRequirementsManager {}
#else
@resultBuilder
public enum AssemblageMemberBuilder<R> where R: AssemblageRequirementsManager {}
#endif

public struct Assemblage<R> where R: AssemblageRequirementsManager {
    public let traits: TraitSet
    unowned let manager: EntityManager

    public init(entityManager: EntityManager,
                requiredComponents: @autoclosure () -> R.ComponentTypes,
                excludedComponents: [Component.Type]) {
        let required = R(requiredComponents())
        let traits = TraitSet(requiredComponents: required.componentTypes, excludedComponents: excludedComponents)
        self.traits = traits
        self.manager = entityManager
        entityManager.onAssemblageInit(traits: traits)
    }

    public var members: Set<EntityID> {
        manager.members(withTraits: traits)
    }

    public var count: Int {
        members.count
    }

    public var isEmpty: Bool {
        members.isEmpty
    }

    public func isMember(entity: Entity) -> Bool {
        manager.isMember(entity, ofAssemblageWithTraits: traits)
    }

    public func canBecomeMember(entity: Entity) -> Bool {
        manager.canBecomeMember(entity, ofAssemblageWithTraits: traits)
    }
}

extension Assemblage: Equatable {
    public static func == (lhs: Assemblage<R>, rhs: Assemblage<R>) -> Bool {
        lhs.manager === rhs.manager && lhs.traits == rhs.traits
    }
}

extension Assemblage: Sequence {
    public func makeIterator() -> ComponentsIterator {
        ComponentsIterator(assemblage: self)
    }
}

extension Assemblage: LazySequenceProtocol {}

extension Assemblage {
    public struct ComponentsIterator: IteratorProtocol {
        var memberIdsIterator: Set<EntityID>.Iterator
        unowned let manager: EntityManager

        public init(assemblage: Assemblage<R>) {
            self.manager = assemblage.manager
            memberIdsIterator = manager.members(withTraits: assemblage.traits).makeIterator()
        }

        public mutating func next() -> R.Components? {
            guard let entityId: EntityID = memberIdsIterator.next() else {
                return nil
            }
            return R.components(entityManager: manager, entityId: entityId)
        }
    }
}

extension Assemblage.ComponentsIterator: LazySequenceProtocol {}
extension Assemblage.ComponentsIterator: Sequence {}

extension Assemblage {
    public var entities: EntityIterator {
        EntityIterator(assemblage: self)
    }

    public struct EntityIterator: IteratorProtocol {
        var memberIdsIterator: Set<EntityID>.Iterator
        unowned let manager: EntityManager

        public init(assemblage: Assemblage<R>) {
            self.manager = assemblage.manager
            memberIdsIterator = manager.members(withTraits: assemblage.traits).makeIterator()
        }

        public mutating func next() -> Entity? {
            guard let entityId = memberIdsIterator.next() else {
                return nil
            }
            return Entity(id: entityId, manager: self.manager)
        }
    }
}

extension Assemblage.EntityIterator: LazySequenceProtocol {}
extension Assemblage.EntityIterator: Sequence {}

extension Assemblage {
    public var entityAndComponents: EntityComponentIterator {
        EntityComponentIterator(assemblage: self)
    }

    public struct EntityComponentIterator: IteratorProtocol {
        var memberIdsIterator: Set<EntityID>.Iterator
        unowned let manager: EntityManager

        public init(assemblage: Assemblage<R>) {
            self.manager = assemblage.manager
            memberIdsIterator = manager.members(withTraits: assemblage.traits).makeIterator()
        }

        public mutating func next() -> R.EntityAndComponents? {
            guard let entityId = memberIdsIterator.next() else {
                return nil
            }
            return R.entityAndComponents(entityManager: manager, entityId: entityId)
        }
    }
}

extension Assemblage.EntityComponentIterator: LazySequenceProtocol {}
extension Assemblage.EntityComponentIterator: Sequence {}

extension Assemblage {
    @discardableResult
    public func createMember(with components: R.Components) -> Entity {
        R.createMember(entityManager: manager, components: components)
    }

    public func getComponents(for entityId: EntityID) -> R.Components? {
        guard isMember(entity: Entity(id: entityId, manager: self.manager)) else {
            return nil
        }
        return R.components(entityManager: manager, entityId: entityId)
    }

    public func getEntityAndComponents(for entityId: EntityID) -> R.EntityAndComponents? {
        guard isMember(entity: Entity(id: entityId, manager: self.manager)) else {
            return nil
        }
        return R.entityAndComponents(entityManager: manager, entityId: entityId)
    }
}
