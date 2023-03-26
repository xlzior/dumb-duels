//
//  SpriteComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

public class SpriteComponent: ComponentInitializable {
    var id: ComponentID
    var assetName: String
    var alpha: CGFloat

    init(assetName: String, alpha: CGFloat = 1) {
        self.id = ComponentID()
        self.assetName = assetName
        self.alpha = alpha
    }

    required init() {
        self.id = ComponentID()
        self.assetName = ""
        self.alpha = 1.0
    }
}
