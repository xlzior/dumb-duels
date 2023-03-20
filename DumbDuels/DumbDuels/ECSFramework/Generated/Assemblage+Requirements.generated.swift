// Generated using Sourcery 2.0.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable file_length
// swiftlint:disable function_parameter_count
// swiftlint:disable large_tuple
// swiftlint:disable line_length
// swiftlint:disable multiline_parameters

// MARK: - Assemblage 1

typealias Assemblage1<Component1> = Assemblage<Requires1<Component1>> where Component1: Component

protocol RequiringComponents1: AssemblageRequirementsManager where Components == (Component1) {
    associatedtype Component1: Component
}

struct Requires1<Component1>: AssemblageRequirementsManager where Component1: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type)) {
        componentTypes = [Component1.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        return (component1)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        return (entity, component1)
    }

    static func createMember(entityManager: EntityManager, components: (Component1)) -> Entity {
        entityManager.createEntity(with: components)
    }
}

extension Requires1: RequiringComponents1 { }

extension AssemblageMemberBuilder where R: RequiringComponents1 {
    static func buildBlock(_ component1: R.Component1) -> (R.Components) {
        (component1)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 1 required components each.
    func assemblage<Component1>(
        requiredComponents component1: Component1.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage1<Component1> where Component1: Component {
        Assemblage1<Component1>(
            entityManager: self,
            requiredComponents: (component1),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 2

typealias Assemblage2<Component1, Component2> = Assemblage<Requires2<Component1, Component2>> where Component1: Component, Component2: Component

protocol RequiringComponents2: AssemblageRequirementsManager where Components == (Component1, Component2) {
    associatedtype Component1: Component
    associatedtype Component2: Component
}

struct Requires2<Component1, Component2>: AssemblageRequirementsManager where Component1: Component, Component2: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type)) {
        componentTypes = [Component1.self, Component2.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        return (component1, component2)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        return (entity, component1, component2)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2)) -> Entity {
        entityManager.createEntity(with: components.0, components.1)
    }
}

extension Requires2: RequiringComponents2 { }

extension AssemblageMemberBuilder where R: RequiringComponents2 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2) -> (R.Components) {
        (component1, component2)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 2 required components each.
    func assemblage<Component1, Component2>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage2<Component1, Component2> where Component1: Component, Component2: Component {
        Assemblage2<Component1, Component2>(
            entityManager: self,
            requiredComponents: (component1, component2),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 3

typealias Assemblage3<Component1, Component2, Component3> = Assemblage<Requires3<Component1, Component2, Component3>> where Component1: Component, Component2: Component, Component3: Component

protocol RequiringComponents3: AssemblageRequirementsManager where Components == (Component1, Component2, Component3) {
    associatedtype Component1: Component
    associatedtype Component2: Component
    associatedtype Component3: Component
}

struct Requires3<Component1, Component2, Component3>: AssemblageRequirementsManager where Component1: Component, Component2: Component, Component3: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type, Component3.Type)) {
        componentTypes = [Component1.self, Component2.self, Component3.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2, Component3) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        return (component1, component2, component3)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2, Component3) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        return (entity, component1, component2, component3)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2, Component3)) -> Entity {
        entityManager.createEntity(with: components.0, components.1, components.2)
    }
}

extension Requires3: RequiringComponents3 { }

extension AssemblageMemberBuilder where R: RequiringComponents3 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2, _ component3: R.Component3) -> (R.Components) {
        (component1, component2, component3)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self, Component3.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2, component3) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - component3: Component type 3 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 3 required components each.
    func assemblage<Component1, Component2, Component3>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type, _ component3: Component3.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage3<Component1, Component2, Component3> where Component1: Component, Component2: Component, Component3: Component {
        Assemblage3<Component1, Component2, Component3>(
            entityManager: self,
            requiredComponents: (component1, component2, component3),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 4

typealias Assemblage4<Component1, Component2, Component3, Component4> = Assemblage<Requires4<Component1, Component2, Component3, Component4>> where Component1: Component, Component2: Component, Component3: Component, Component4: Component

protocol RequiringComponents4: AssemblageRequirementsManager where Components == (Component1, Component2, Component3, Component4) {
    associatedtype Component1: Component
    associatedtype Component2: Component
    associatedtype Component3: Component
    associatedtype Component4: Component
}

struct Requires4<Component1, Component2, Component3, Component4>: AssemblageRequirementsManager where Component1: Component, Component2: Component, Component3: Component, Component4: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type, Component3.Type, Component4.Type)) {
        componentTypes = [Component1.self, Component2.self, Component3.self, Component4.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2, Component3, Component4) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        return (component1, component2, component3, component4)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2, Component3, Component4) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        return (entity, component1, component2, component3, component4)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2, Component3, Component4)) -> Entity {
        entityManager.createEntity(with: components.0, components.1, components.2, components.3)
    }
}

extension Requires4: RequiringComponents4 { }

extension AssemblageMemberBuilder where R: RequiringComponents4 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2, _ component3: R.Component3, _ component4: R.Component4) -> (R.Components) {
        (component1, component2, component3, component4)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self, Component3.self, Component4.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2, component3, component4) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - component3: Component type 3 required by members of this assemblage.
    ///   - component4: Component type 4 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 4 required components each.
    func assemblage<Component1, Component2, Component3, Component4>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type, _ component3: Component3.Type, _ component4: Component4.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage4<Component1, Component2, Component3, Component4> where Component1: Component, Component2: Component, Component3: Component, Component4: Component {
        Assemblage4<Component1, Component2, Component3, Component4>(
            entityManager: self,
            requiredComponents: (component1, component2, component3, component4),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 5

typealias Assemblage5<Component1, Component2, Component3, Component4, Component5> = Assemblage<Requires5<Component1, Component2, Component3, Component4, Component5>> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component

protocol RequiringComponents5: AssemblageRequirementsManager where Components == (Component1, Component2, Component3, Component4, Component5) {
    associatedtype Component1: Component
    associatedtype Component2: Component
    associatedtype Component3: Component
    associatedtype Component4: Component
    associatedtype Component5: Component
}

struct Requires5<Component1, Component2, Component3, Component4, Component5>: AssemblageRequirementsManager where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type, Component3.Type, Component4.Type, Component5.Type)) {
        componentTypes = [Component1.self, Component2.self, Component3.self, Component4.self, Component5.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2, Component3, Component4, Component5) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        return (component1, component2, component3, component4, component5)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2, Component3, Component4, Component5) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        return (entity, component1, component2, component3, component4, component5)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2, Component3, Component4, Component5)) -> Entity {
        entityManager.createEntity(with: components.0, components.1, components.2, components.3, components.4)
    }
}

extension Requires5: RequiringComponents5 { }

extension AssemblageMemberBuilder where R: RequiringComponents5 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2, _ component3: R.Component3, _ component4: R.Component4, _ component5: R.Component5) -> (R.Components) {
        (component1, component2, component3, component4, component5)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self, Component3.self, Component4.self, Component5.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2, component3, component4, component5) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - component3: Component type 3 required by members of this assemblage.
    ///   - component4: Component type 4 required by members of this assemblage.
    ///   - component5: Component type 5 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 5 required components each.
    func assemblage<Component1, Component2, Component3, Component4, Component5>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type, _ component3: Component3.Type, _ component4: Component4.Type, _ component5: Component5.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage5<Component1, Component2, Component3, Component4, Component5> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component {
        Assemblage5<Component1, Component2, Component3, Component4, Component5>(
            entityManager: self,
            requiredComponents: (component1, component2, component3, component4, component5),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 6

typealias Assemblage6<Component1, Component2, Component3, Component4, Component5, Component6> = Assemblage<Requires6<Component1, Component2, Component3, Component4, Component5, Component6>> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component

protocol RequiringComponents6: AssemblageRequirementsManager where Components == (Component1, Component2, Component3, Component4, Component5, Component6) {
    associatedtype Component1: Component
    associatedtype Component2: Component
    associatedtype Component3: Component
    associatedtype Component4: Component
    associatedtype Component5: Component
    associatedtype Component6: Component
}

struct Requires6<Component1, Component2, Component3, Component4, Component5, Component6>: AssemblageRequirementsManager where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type, Component3.Type, Component4.Type, Component5.Type, Component6.Type)) {
        componentTypes = [Component1.self, Component2.self, Component3.self, Component4.self, Component5.self, Component6.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2, Component3, Component4, Component5, Component6) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        let component6: Component6 = entityManager.getComponent(ofType: Component6.typeId, for: entityId)!
        return (component1, component2, component3, component4, component5, component6)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2, Component3, Component4, Component5, Component6) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        let component6: Component6 = entityManager.getComponent(ofType: Component6.typeId, for: entityId)!
        return (entity, component1, component2, component3, component4, component5, component6)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2, Component3, Component4, Component5, Component6)) -> Entity {
        entityManager.createEntity(with: components.0, components.1, components.2, components.3, components.4, components.5)
    }
}

extension Requires6: RequiringComponents6 { }

extension AssemblageMemberBuilder where R: RequiringComponents6 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2, _ component3: R.Component3, _ component4: R.Component4, _ component5: R.Component5, _ component6: R.Component6) -> (R.Components) {
        (component1, component2, component3, component4, component5, component6)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self, Component3.self, Component4.self, Component5.self, Component6.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2, component3, component4, component5, component6) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - component3: Component type 3 required by members of this assemblage.
    ///   - component4: Component type 4 required by members of this assemblage.
    ///   - component5: Component type 5 required by members of this assemblage.
    ///   - component6: Component type 6 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 6 required components each.
    func assemblage<Component1, Component2, Component3, Component4, Component5, Component6>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type, _ component3: Component3.Type, _ component4: Component4.Type, _ component5: Component5.Type, _ component6: Component6.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage6<Component1, Component2, Component3, Component4, Component5, Component6> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component {
        Assemblage6<Component1, Component2, Component3, Component4, Component5, Component6>(
            entityManager: self,
            requiredComponents: (component1, component2, component3, component4, component5, component6),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 7

typealias Assemblage7<Component1, Component2, Component3, Component4, Component5, Component6, Component7> = Assemblage<Requires7<Component1, Component2, Component3, Component4, Component5, Component6, Component7>> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component, Component7: Component

protocol RequiringComponents7: AssemblageRequirementsManager where Components == (Component1, Component2, Component3, Component4, Component5, Component6, Component7) {
    associatedtype Component1: Component
    associatedtype Component2: Component
    associatedtype Component3: Component
    associatedtype Component4: Component
    associatedtype Component5: Component
    associatedtype Component6: Component
    associatedtype Component7: Component
}

struct Requires7<Component1, Component2, Component3, Component4, Component5, Component6, Component7>: AssemblageRequirementsManager where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component, Component7: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type, Component3.Type, Component4.Type, Component5.Type, Component6.Type, Component7.Type)) {
        componentTypes = [Component1.self, Component2.self, Component3.self, Component4.self, Component5.self, Component6.self, Component7.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2, Component3, Component4, Component5, Component6, Component7) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        let component6: Component6 = entityManager.getComponent(ofType: Component6.typeId, for: entityId)!
        let component7: Component7 = entityManager.getComponent(ofType: Component7.typeId, for: entityId)!
        return (component1, component2, component3, component4, component5, component6, component7)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2, Component3, Component4, Component5, Component6, Component7) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        let component6: Component6 = entityManager.getComponent(ofType: Component6.typeId, for: entityId)!
        let component7: Component7 = entityManager.getComponent(ofType: Component7.typeId, for: entityId)!
        return (entity, component1, component2, component3, component4, component5, component6, component7)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2, Component3, Component4, Component5, Component6, Component7)) -> Entity {
        entityManager.createEntity(with: components.0, components.1, components.2, components.3, components.4, components.5, components.6)
    }
}

extension Requires7: RequiringComponents7 { }

extension AssemblageMemberBuilder where R: RequiringComponents7 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2, _ component3: R.Component3, _ component4: R.Component4, _ component5: R.Component5, _ component6: R.Component6, _ component7: R.Component7) -> (R.Components) {
        (component1, component2, component3, component4, component5, component6, component7)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self, Component3.self, Component4.self, Component5.self, Component6.self, Component7.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2, component3, component4, component5, component6, component7) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - component3: Component type 3 required by members of this assemblage.
    ///   - component4: Component type 4 required by members of this assemblage.
    ///   - component5: Component type 5 required by members of this assemblage.
    ///   - component6: Component type 6 required by members of this assemblage.
    ///   - component7: Component type 7 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 7 required components each.
    func assemblage<Component1, Component2, Component3, Component4, Component5, Component6, Component7>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type, _ component3: Component3.Type, _ component4: Component4.Type, _ component5: Component5.Type, _ component6: Component6.Type, _ component7: Component7.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage7<Component1, Component2, Component3, Component4, Component5, Component6, Component7> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component, Component7: Component {
        Assemblage7<Component1, Component2, Component3, Component4, Component5, Component6, Component7>(
            entityManager: self,
            requiredComponents: (component1, component2, component3, component4, component5, component6, component7),
            excludedComponents: excludedComponents
        )
    }
}

// MARK: - Assemblage 8

typealias Assemblage8<Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8> = Assemblage<Requires8<Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8>> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component, Component7: Component, Component8: Component

protocol RequiringComponents8: AssemblageRequirementsManager where Components == (Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8) {
    associatedtype Component1: Component
    associatedtype Component2: Component
    associatedtype Component3: Component
    associatedtype Component4: Component
    associatedtype Component5: Component
    associatedtype Component6: Component
    associatedtype Component7: Component
    associatedtype Component8: Component
}

struct Requires8<Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8>: AssemblageRequirementsManager where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component, Component7: Component, Component8: Component {
    let componentTypes: [Component.Type]

    init(_ components: (Component1.Type, Component2.Type, Component3.Type, Component4.Type, Component5.Type, Component6.Type, Component7.Type, Component8.Type)) {
        componentTypes = [Component1.self, Component2.self, Component3.self, Component4.self, Component5.self, Component6.self, Component7.self, Component8.self]
    }

    static func components(entityManager: EntityManager, entityId: EntityID) -> (Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8) {
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        let component6: Component6 = entityManager.getComponent(ofType: Component6.typeId, for: entityId)!
        let component7: Component7 = entityManager.getComponent(ofType: Component7.typeId, for: entityId)!
        let component8: Component8 = entityManager.getComponent(ofType: Component8.typeId, for: entityId)!
        return (component1, component2, component3, component4, component5, component6, component7, component8)
    }

    static func entityAndComponents(entityManager: EntityManager, entityId: EntityID) -> (Entity, Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8) {
        let entity = Entity(id: entityId, manager: entityManager)
        let component1: Component1 = entityManager.getComponent(ofType: Component1.typeId, for: entityId)!
        let component2: Component2 = entityManager.getComponent(ofType: Component2.typeId, for: entityId)!
        let component3: Component3 = entityManager.getComponent(ofType: Component3.typeId, for: entityId)!
        let component4: Component4 = entityManager.getComponent(ofType: Component4.typeId, for: entityId)!
        let component5: Component5 = entityManager.getComponent(ofType: Component5.typeId, for: entityId)!
        let component6: Component6 = entityManager.getComponent(ofType: Component6.typeId, for: entityId)!
        let component7: Component7 = entityManager.getComponent(ofType: Component7.typeId, for: entityId)!
        let component8: Component8 = entityManager.getComponent(ofType: Component8.typeId, for: entityId)!
        return (entity, component1, component2, component3, component4, component5, component6, component7, component8)
    }

    static func createMember(entityManager: EntityManager, components: (Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8)) -> Entity {
        entityManager.createEntity(with: components.0, components.1, components.2, components.3, components.4, components.5, components.6, components.7)
    }
}

extension Requires8: RequiringComponents8 { }

extension AssemblageMemberBuilder where R: RequiringComponents8 {
    static func buildBlock(_ component1: R.Component1, _ component2: R.Component2, _ component3: R.Component3, _ component4: R.Component4, _ component5: R.Component5, _ component6: R.Component6, _ component7: R.Component7, _ component8: R.Component8) -> (R.Components) {
        (component1, component2, component3, component4, component5, component6, component7, component8)
    }
}

extension EntityManager {
    /// A assemblage conforms to the `LazySequenceProtocol` and therefore can be accessed like any other (lazy) sequence.
    ///
    /// **General usage**
    /// ```swift
    /// let assemblage = entityManager.assemblage(requiredComponents: Component1.self, Component2.self, Component3.self, Component4.self, Component5.self, Component6.self, Component7.self, Component8.self)
    /// // iterate each entity's components
    /// assemblage.forEach { (component1, component2, component3, component4, component5, component6, component7, component8) in
    ///   ...
    /// }
    /// ```
    /// - Parameters:
    ///   - component1: Component type 1 required by members of this assemblage.
    ///   - component2: Component type 2 required by members of this assemblage.
    ///   - component3: Component type 3 required by members of this assemblage.
    ///   - component4: Component type 4 required by members of this assemblage.
    ///   - component5: Component type 5 required by members of this assemblage.
    ///   - component6: Component type 6 required by members of this assemblage.
    ///   - component7: Component type 7 required by members of this assemblage.
    ///   - component8: Component type 8 required by members of this assemblage.
    ///   - excludedComponents: All component types that must not be assigned to an entity in this assemblage.
    /// - Returns: The assemblage of entities having 8 required components each.
    func assemblage<Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8>(
        requiredComponents component1: Component1.Type, _ component2: Component2.Type, _ component3: Component3.Type, _ component4: Component4.Type, _ component5: Component5.Type, _ component6: Component6.Type, _ component7: Component7.Type, _ component8: Component8.Type,
        excludedComponents: Component.Type...
    ) -> Assemblage8<Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8> where Component1: Component, Component2: Component, Component3: Component, Component4: Component, Component5: Component, Component6: Component, Component7: Component, Component8: Component {
        Assemblage8<Component1, Component2, Component3, Component4, Component5, Component6, Component7, Component8>(
            entityManager: self,
            requiredComponents: (component1, component2, component3, component4, component5, component6, component7, component8),
            excludedComponents: excludedComponents
        )
    }
}
