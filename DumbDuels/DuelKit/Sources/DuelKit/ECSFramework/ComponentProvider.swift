//
//  ComponentProvider.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 16/3/23.
//

import Foundation

public protocol DefaultInitializable {
    init()
}

typealias ComponentInitializable = Component & DefaultInitializable

protocol ComponentProvider {
    var identifier: AnyHashable { get }
    func getComponent() -> Component
}

public final class ComponentInstanceProvider {
    private var instance: Component

    init(instance: Component) {
        self.instance = instance
    }
}

extension ComponentInstanceProvider: ComponentProvider {

    /// Any two providers that returns the same component instance should be considered equivalent
    public var identifier: AnyHashable {
        ObjectIdentifier(instance)
    }

    func getComponent() -> Component {
        instance
    }
}

public final class ComponentTypeProvider {
    private var componentType: ComponentInitializable.Type

    public let identifier: AnyHashable

    init(componentType: ComponentInitializable.Type) {
        self.componentType = componentType
        identifier = ObjectIdentifier(componentType.self)
    }
}

extension ComponentTypeProvider: ComponentProvider {
    func getComponent() -> Component {
        componentType.init()
    }
}

final class DynamicComponentProvider<C: Component> {
    /// A wrapper class is needed for the provideComponent function to make it hashable using ObjectIdentifier
    public final class Closure {
        let provideComponent: () -> C

        public init (provideComponent: @escaping () -> C) {
            self.provideComponent = provideComponent
        }
    }

    private let closure: Closure

    init(closure: Closure) {
        self.closure = closure
    }
}

extension DynamicComponentProvider: ComponentProvider {
    public var identifier: AnyHashable {
        ObjectIdentifier(closure)
    }

    public func getComponent() -> Component {
        closure.provideComponent()
    }
}
