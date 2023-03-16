//
//  SizeComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 16/3/23.
//

import CoreGraphics

class SizeComponent: Component {
    var id: ComponentID
    let originalSize: CGSize
    var xScale: CGFloat
    var yScale: CGFloat
    
    init(originalSize: CGSize, xScale: CGFloat = 1, yScale: CGFloat = 1) {
        self.id = ComponentID()
        self.originalSize = originalSize
        self.xScale = xScale
        self.yScale = yScale
    }
}
