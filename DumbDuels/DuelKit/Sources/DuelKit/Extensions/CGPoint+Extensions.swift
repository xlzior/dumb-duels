//
//  CGPoint+Extensions.swift
//  DuelKit
//
//  Created by Esmanda Wong on 17/3/23.
//

import CoreGraphics

extension CGPoint: Interpolatable {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func *= (left: inout CGPoint, right: CGFloat) {
        left = left * right
    }

    static func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x / scalar, y: point.y / scalar)
    }

    func length() -> CGFloat {
        sqrt(x * x + y * y)
    }

    func distanceTo(_ otherPoint: CGPoint) -> Double {
        (self - otherPoint).length()
    }

    static func random(within rect: CGRect) -> CGPoint {
        CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX),
                y: CGFloat.random(in: rect.minY...rect.maxY))
    }
}
