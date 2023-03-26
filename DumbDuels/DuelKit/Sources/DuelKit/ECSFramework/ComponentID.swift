//
//  ComponentID.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

public struct ComponentID {
    typealias ID = String

    let id: ID

    init(_ id: ID = UUID().uuidString) {
        self.id = id
    }
}

extension ComponentID: Equatable {}
extension ComponentID: Hashable {}
