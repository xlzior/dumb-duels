//
//  SpriteComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

class SpriteComponent: Component {
    var id: ComponentID
    var assetName: String
    var alpha: CGFloat

    init(assetName: String, alpha: CGFloat = 1) {
        self.id = ComponentID()
        self.assetName = assetName
        self.alpha = alpha
    }
}
