//
//  SizeComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

public class SizeComponent: Component {
    public var id: ComponentID
    public var originalSize: CGSize
    public var xScale: CGFloat
    public var yScale: CGFloat
    public var actualSize: CGSize {
        CGSize(width: originalSize.width * xScale, height: originalSize.height * yScale)
    }

    public init(originalSize: CGSize, xScale: CGFloat = 1, yScale: CGFloat = 1) {
        self.id = ComponentID()
        self.originalSize = originalSize
        self.xScale = xScale
        self.yScale = yScale
    }
}
