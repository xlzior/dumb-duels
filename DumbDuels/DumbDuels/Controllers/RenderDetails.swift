//
//  RenderDetails.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 17/3/23.
//

import CoreGraphics

struct RenderDetails {
    let spriteName: String
    let alpha: CGFloat
    let centerPosition: CGPoint
    let width: CGFloat
    let height: CGFloat
    let rotation: CGFloat

    init(spriteName: String,
         alpha: CGFloat,
         centerPosition: CGPoint,
         width: CGFloat,
         height: CGFloat,
         rotation: CGFloat) {
        self.spriteName = spriteName
        self.alpha = alpha
        self.centerPosition = centerPosition
        self.width = width
        self.height = height
        self.rotation = rotation
    }
}
