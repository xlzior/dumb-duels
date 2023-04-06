//
//  AutoRotateComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 28/3/23.
//

import CoreGraphics
import DuelKit

class AutoRotateComponent: Component {
    var id: ComponentID
    var anglePerLoop: CGFloat

    init(by anglePerLoop: CGFloat) {
        self.id = ComponentID()
        self.anglePerLoop = anglePerLoop
    }
}
