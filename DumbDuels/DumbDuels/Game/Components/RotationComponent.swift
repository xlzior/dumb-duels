//
//  RotationComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

class RotationComponent: Component {
    var id: ComponentID
    var angleInRadians: CGFloat

    init(angleInRadians: CGFloat = 0) {
        self.id = ComponentID()
        self.angleInRadians = angleInRadians
    }
}
