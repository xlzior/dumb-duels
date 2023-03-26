//
//  EntityID.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

public struct EntityID {
    public typealias ID = String

    let id: ID

    public init(_ id: ID = UUID().uuidString) {
        self.id = id
    }
}

extension EntityID: Equatable {}
extension EntityID: Hashable {}
