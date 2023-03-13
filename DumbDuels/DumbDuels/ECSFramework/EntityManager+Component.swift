//
//  EntityManager+Component.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation

extension EntityManager {
    var numComponents: Int {
        componentsByType.reduce(0) {
            $0 + $1.value.keys.count
        }
    }
    
    func has(componentTypeId: ComponentTypeID, entityId: EntityID) -> Bool {
        return false
    }
}
