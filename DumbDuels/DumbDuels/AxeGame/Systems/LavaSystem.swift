//
//  LavaSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 27/3/23.
//

import DuelKit
import CoreGraphics

class LavaSystem: System {
    unowned var entityCreator: EntityCreator

    init(entityCreator: EntityCreator) {
        self.entityCreator = entityCreator
    }

    func update() {
        let randomNumber = Int.random(in: 0...10)
        if randomNumber < 2 { // to limit the amount of lava
            let xPosition = CGFloat.random(in: 0...Sizes.game.width)
            _ = entityCreator.createLavaSmoke(at: CGPoint(x: xPosition, y: AXSizes.lava.height), of: AXSizes.particle)
        }
    }
}
