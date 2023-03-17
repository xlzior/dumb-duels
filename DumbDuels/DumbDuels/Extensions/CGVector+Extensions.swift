//
//  CGVector+Extensions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 17/3/23.
//

import CoreGraphics

extension CGVector {
    public static func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
        CGVector(dx: lhs * rhs.dx, dy: lhs * rhs.dy)
    }
}
