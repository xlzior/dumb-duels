//
//  CannonballComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import Foundation
import DuelKit

class CannonballComponent: Component {
    var id: ComponentID
    var expiryDate: Date

    init(expiring expiryDate: Date) {
        self.id = ComponentID()
        self.expiryDate = expiryDate
    }
}
