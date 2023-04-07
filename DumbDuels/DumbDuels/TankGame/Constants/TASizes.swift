//
//  TASizes.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics

struct TASizes {
    static let wallThickness: CGFloat = 10
    static let wallLength: CGFloat = 50

    static let walls = [
        CGSize(width: 2 * wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: 2 * wallLength),
        CGSize(width: wallLength, height: wallThickness),
        CGSize(width: wallThickness, height: wallLength),
        CGSize(width: wallThickness, height: wallLength),
        CGSize(width: 2 * wallLength, height: wallThickness)
    ]

    static let tank = CGSize(width: 80, height: 80)
}
