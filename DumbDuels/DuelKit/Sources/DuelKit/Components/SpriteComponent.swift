//
//  SpriteComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

public class SpriteComponent: ComponentInitializable {
    public var id: ComponentID
    public var assetName: String
    public var alpha: CGFloat
    public var zPosition: CGFloat

    public init(assetName: String, alpha: CGFloat = 1, zPosition: CGFloat = 0) {
        self.id = ComponentID()
        self.assetName = assetName
        self.alpha = alpha
        self.zPosition = zPosition
    }

    public required init() {
        self.id = ComponentID()
        self.assetName = ""
        self.alpha = 1.0
        self.zPosition = 0
    }
}
