//
//  ComponentTypeID.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation
public struct ComponentTypeID {
    typealias ID = Int
    let id: ID
}

extension ComponentTypeID {
    init<C>(_ componentType: C.Type) where C: Component {
        self.id = Self.makeRuntimeHash(componentType)
    }

    static func makeRuntimeHash<C>(_ componentType: C.Type) -> ID where C: Component {
        ObjectIdentifier(componentType).hashValue
    }
}

extension ComponentTypeID: Equatable {}
extension ComponentTypeID: Hashable {}
