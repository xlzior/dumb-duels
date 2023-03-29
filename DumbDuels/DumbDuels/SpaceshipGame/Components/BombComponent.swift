//
//  BombComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import Foundation
import DuelKit

class BombComponent: Component {
    var id: ComponentID
    var numBullets: Int
    // Defines the circle around the bomb where bullets are first initialized
    var startingRadius: CGFloat

    init(numBullets: Int = SPConstants.bombNumBullets, startingRadius: CGFloat = SPConstants.bombRadius) {
        self.id = ComponentID()
        self.numBullets = numBullets
        self.startingRadius = startingRadius
    }
}
