//
//  AnimationFrame.swift
//  DuelKit
//
//  Created by Esmanda Wong on 24/3/23.
//

import CoreGraphics

public struct AnimationFrame {
    public var frameDuration: Double
    public var spriteName: String?
    public var alpha: CGFloat?
    public var deltaPosition: CGPoint?
    public var xScale: CGFloat?
    public var yScale: CGFloat?
    public var rotationAngle: CGFloat?

    public init(
        frameDuration: Double,
        spriteName: String? = nil,
        alpha: CGFloat? = nil,
        deltaPosition: CGPoint? = nil,
        xScale: CGFloat? = nil,
        yScale: CGFloat? = nil,
        rotationAngle: CGFloat? = nil
    ) {
        self.frameDuration = frameDuration
        self.spriteName = spriteName
        self.alpha = alpha
        self.deltaPosition = deltaPosition
        self.xScale = xScale
        self.yScale = yScale
        self.rotationAngle = rotationAngle
    }
}
