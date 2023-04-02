//
//  CGFloat+Extensions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics

extension CGFloat {
    func modulo(_ other: CGFloat) -> CGFloat {
        let r = self.truncatingRemainder(dividingBy: other)
        return r >= 0 ? r : r + other
    }
}
