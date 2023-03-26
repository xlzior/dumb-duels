//
//  Component.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

public protocol Component: AnyObject {
    static var typeId: ComponentTypeID { get }

    var id: ComponentID { get set }
    var typeId: ComponentTypeID { get }
}

extension Component {
    static var typeId: ComponentTypeID {
        ComponentTypeID(Self.self)
    }

    var id: ComponentID {
        self.id
    }

    var typeId: ComponentTypeID {
        Self.typeId
    }
}
