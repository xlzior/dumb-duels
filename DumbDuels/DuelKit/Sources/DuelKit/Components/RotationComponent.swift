//
//  RotationComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

public class RotationComponent: Component {
    public var id: ComponentID
    public var angleInRadians: CGFloat

    public init(angleInRadians: CGFloat = 0) {
        self.id = ComponentID()
        self.angleInRadians = angleInRadians
    }
}
