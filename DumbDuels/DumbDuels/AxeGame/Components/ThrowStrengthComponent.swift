//
//  ThrowStrengthComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 23/3/23.
//

import CoreGraphics

class ThrowStrengthComponent: Component {
    var id: ComponentID
    var throwStrength = Constants.minimumThrowStrength

    /// Whether the throw strength is increasing or decreasing
    var multiplier: CGFloat = 1.0

    init() {
        self.id = ComponentID()
    }
}
