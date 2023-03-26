//
//  PositionComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

public enum FaceDirection: CGFloat {
    case left = -1.0
    case right = 1.0
}

public class PositionComponent: Component {
    var id: ComponentID
    var position: CGPoint
    var faceDirection: FaceDirection

    init(position: CGPoint, faceDirection: FaceDirection = .right) {
        self.id = ComponentID()
        self.position = position
        self.faceDirection = faceDirection
    }
}
