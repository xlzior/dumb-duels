//
//  Positions.swift
//  
//
//  Created by Wen Jun Lye on 31/3/23.
//

import CoreGraphics

public struct Positions {
    static let text = CGPoint(x: Sizes.game.width / 2, y: Sizes.game.height * 2 / 3)

    public static func random2(withBuffer buffer: CGFloat) -> (CGPoint, CGPoint) {
        let safeArea = Sizes.gameRect.insetBy(dx: buffer / 2, dy: buffer / 2)
        let firstPosition = CGPoint.random(within: safeArea)
        var secondPosition = CGPoint.random(within: safeArea)
        while secondPosition.distanceTo(firstPosition) < buffer {
            secondPosition = CGPoint.random(within: safeArea)
        }
        return (firstPosition, secondPosition)
    }
}
