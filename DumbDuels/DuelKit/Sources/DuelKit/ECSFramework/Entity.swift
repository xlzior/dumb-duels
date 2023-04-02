//
//  Entity.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

public struct Entity {
    public private(set) var id: EntityID
    unowned let manager: EntityManager

    init(id: EntityID, manager: EntityManager) {
        self.id = id
        self.manager = manager
    }

    @discardableResult
    public func remove(componentType: ComponentTypeID) -> Entity {
        manager.remove(componentType: componentType, from: self.id)
        return self
    }

    @discardableResult
    public func assign(component: Component) -> Entity {
        manager.assign(component: component, to: self)
        return self
    }
}

extension Entity: Equatable {
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.manager === rhs.manager && lhs.id == rhs.id
    }
}
