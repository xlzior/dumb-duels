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
    public static var typeId: ComponentTypeID {
        ComponentTypeID(Self.self)
    }

    public var id: ComponentID {
        self.id
    }

    public var typeId: ComponentTypeID {
        Self.typeId
    }
}
