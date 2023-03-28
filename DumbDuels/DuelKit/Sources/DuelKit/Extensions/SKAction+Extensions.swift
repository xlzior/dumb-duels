//
//  SKAction+Extensions.swift
//  
//
//  Created by Bryan Kwok on 28/3/23.
//

import Foundation
import SpriteKit

extension SKAction {
    static func oscillation(centerOfOscillation: CGPoint, axis: CGVector, amplitude a: CGFloat,
                            period t: CGFloat, initialDisplacement: Double) -> SKAction {
        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
            let displacement = a * sin(2 * Double.pi * currentTime / t + initialDisplacement)
            let xDisplacement = displacement * cos(abs(axis.angle))
            let yDisplacement = displacement * sin(abs(axis.angle))
            let newPosition = CGPoint(x: centerOfOscillation.x + xDisplacement,
                                      y: centerOfOscillation.y + yDisplacement)
            node.position = newPosition
        }

        return action
    }
}
