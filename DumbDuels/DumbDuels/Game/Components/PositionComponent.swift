//
//  PositionComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

class PositionComponent: Component {
    var id: ComponentID
    var position: CGPoint

    init(position: CGPoint) {
        self.id = ComponentID()
        self.position = position
    }
}

extension PositionComponent {
    enum FaceDirection: CGFloat {
        case left = -1.0
        case right = 1.0
    }
}
