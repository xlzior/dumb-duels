//
//  Component.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation
class Component {
    static var typeId: ComponentTypeID {
        ComponentTypeID(Self.self)
    }
    
    var id: ComponentID
    var typeId: ComponentTypeID {
        Self.typeId
    }
    
    init() {
        self.id = ComponentID()
    }
}

extension Component: Equatable {
    static func == (lhs: Component, rhs: Component) -> Bool {
        lhs.id == rhs.id
    }
}

extension Component: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
