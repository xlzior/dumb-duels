//
//  FSM.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 16/3/23.
//

import Foundation

public class EntityState {
    var providers = [ComponentTypeID: ComponentProvider]()

    public init() {}

    @discardableResult
    func addMapping(forType type: ComponentInitializable.Type) -> StateComponentMapping {
        StateComponentMapping(creatingState: self, type: type)
    }

    func getProvider(forType type: ComponentInitializable.Type) -> ComponentProvider? {
        providers[type.typeId]
    }

    func hasProvider(forType type: ComponentInitializable.Type) -> Bool {
        providers[type.typeId] != nil
    }
}

extension EntityState {
    @discardableResult
    func addInstance<C: ComponentInitializable>(_ component: C) -> Self {
        addMapping(forType: C.self).withInstance(component)
        return self
    }

    @discardableResult
    func addType(_ componentType: ComponentInitializable.Type) -> Self {
        addMapping(forType: componentType).withType(componentType)
        return self
    }

    @discardableResult
    func addMethod<C: ComponentInitializable>(closure: DynamicComponentProvider<C>.Closure) -> Self {
        addMapping(forType: C.self).withMethod(closure)
        return self
    }

    @discardableResult
    func addProvider<C: ComponentInitializable>(componentType: C.Type, provider: ComponentProvider) -> Self {
        addMapping(forType: componentType).withProvider(provider)
        return self
    }
}

public class StateComponentMapping {
    private var componentType: ComponentInitializable.Type
    private let creatingState: EntityState
    private var provider: ComponentProvider

    init(creatingState: EntityState, type: ComponentInitializable.Type) {
        self.creatingState = creatingState
        componentType = type
        provider = ComponentTypeProvider(componentType: type)
        setProvider(provider)
    }

    @discardableResult
    func withInstance(_ component: Component) -> StateComponentMapping {
        setProvider(ComponentInstanceProvider(instance: component))
        return self
    }

    @discardableResult
    func withType(_ componentType: ComponentInitializable.Type) -> Self {
        setProvider(ComponentTypeProvider(componentType: componentType))
        return self
    }

    @discardableResult
    func withMethod<C: Component>(_ closure: DynamicComponentProvider<C>.Closure) -> Self {
        setProvider(DynamicComponentProvider(closure: closure))
        return self
    }

    @discardableResult
    func withProvider(_ provider: ComponentProvider) -> Self {
        setProvider(provider)
        return self
    }

    @discardableResult
    func add(componentType: ComponentInitializable.Type) -> StateComponentMapping {
        creatingState.addMapping(forType: componentType)
    }

    private func setProvider(_ provider: ComponentProvider) {
        self.provider = provider
        creatingState.providers[componentType.typeId] = provider
    }
}

public class EntityStateMachine<StateIdentifier: Hashable> {
    private var states: [StateIdentifier: EntityState]

    /// The current state of the state machine.
    private var currentState: EntityState?

    /// The entity whose state machine this is
    var entity: Entity

    /// Initializer. Creates an EntityStateMachine.
    init(entity: Entity) {
        self.entity = entity
        states = [:]
    }

    /// Add a state to this state machine.
    /// - Parameter name: The name of this state - used to identify it later in the changeState method call.
    /// - Parameter state: The state.
    /// - Returns: This state machine, so methods can be chained.
    @discardableResult
    public func addState(name: StateIdentifier, state: EntityState) -> Self {
        states[name] = state
        return self
    }

    /// Create a new state in this state machine.
    /// - Parameter name: The name of the new state - used to identify it later in the changeState method call.
    /// - Returns: The new EntityState object that is the state. This will need to be configured with
    /// the appropriate component providers.
    @discardableResult
    public func createState(name: StateIdentifier) -> EntityState {
        let state = EntityState()
        states[name] = state
        return state
    }

    /// Change to a new state. The components from the old state will be removed and the components
    /// for the new state will be added.
    /// - Parameter name: The name of the state to change to.
    public func changeState(name: StateIdentifier) {
        guard let newState = states[name] else {
            assertionFailure("Entity state '\(name)' doesn't exist")
            return
        }

        if newState === currentState {
            return
        }
        var toAdd: [ComponentTypeID: ComponentProvider]

        if let currentState = currentState {
            toAdd = .init()
            for (componentTypeId, provider) in newState.providers {
                toAdd[componentTypeId] = provider
            }

            for (componentTypeId, _) in currentState.providers {
                if let other = toAdd[componentTypeId], let current = currentState.providers[componentTypeId],
                   current.identifier == other.identifier {
                    toAdd[componentTypeId] = nil
                } else {
                    entity.remove(componentType: componentTypeId)
                }
            }
        } else {
            toAdd = newState.providers
        }

        for (_, provider) in toAdd {
            entity.assign(component: provider.getComponent())
        }
        currentState = newState
    }
}
