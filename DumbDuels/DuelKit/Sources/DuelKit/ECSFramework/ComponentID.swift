//
//  ComponentID.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

public struct ComponentID {
    public typealias ID = String

    let id: ID

    public init(_ id: ID = UUID().uuidString) {
        self.id = id
    }
}

extension ComponentID: Equatable {}
extension ComponentID: Hashable {}
