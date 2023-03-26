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
    public var id: ComponentID
    public var position: CGPoint
    public var faceDirection: FaceDirection

    public init(position: CGPoint, faceDirection: FaceDirection = .right) {
        self.id = ComponentID()
        self.position = position
        self.faceDirection = faceDirection
    }
}
