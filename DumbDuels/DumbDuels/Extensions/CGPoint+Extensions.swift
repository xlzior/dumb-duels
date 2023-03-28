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

    static func + (left: CGPoint, right: CGVector) -> CGPoint {
        CGPoint(x: left.x + right.dx, y: left.y + right.dy)
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

    static func - (left: CGPoint, right: CGPoint) -> CGVector {
        CGVector(dx: left.x - right.x, dy: left.y - right.y)
    }

    func length() -> CGFloat {
        sqrt(x * x + y * y)
    }

    func toVector() -> CGVector {
        CGVector(dx: x, dy: y)
    }

    static func random(within size: CGSize) -> CGPoint {
        CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
    }
}
