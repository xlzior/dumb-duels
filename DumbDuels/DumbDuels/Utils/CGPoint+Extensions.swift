//
//  CGPoint+Extensions.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 17/3/23.
//

import CoreGraphics

extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func *= (left: inout CGPoint, right: CGFloat) {
        left = left * right
    }

}
