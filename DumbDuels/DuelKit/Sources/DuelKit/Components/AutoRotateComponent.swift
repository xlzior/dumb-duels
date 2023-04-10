//
//  AutoRotateComponent.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 28/3/23.
//

import CoreGraphics

public class AutoRotateComponent: Component {
    public var id: ComponentID
    var anglePerLoop: CGFloat

    public init(by anglePerLoop: CGFloat) {
        self.id = ComponentID()
        self.anglePerLoop = anglePerLoop
    }
}
