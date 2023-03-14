//
//  ComponentID.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

struct ComponentID {
    typealias ID = String
    
    let id: ID
    
    init() {
        self.id = UUID().uuidString
    }
}

extension ComponentID: Equatable {}
extension ComponentID: Hashable {}
