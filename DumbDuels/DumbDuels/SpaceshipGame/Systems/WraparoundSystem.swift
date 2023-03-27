//
//  WraparoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class WraparoundSystem: System {
    unowned var entityManager: EntityManager
    private var objects: Assemblage1<PositionComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.objects = entityManager.assemblage(requiredComponents: PositionComponent.self)
    }

    func update() {
        let frame = CGRect(origin: CGPoint.zero, size: Sizes.game)
        for position in objects where !frame.contains(position.position) {
            let newX = position.position.x.modulo(frame.width)
            let newY = position.position.y.modulo(frame.height)
            position.position = CGPoint(x: newX, y: newY)
        }
    }
}
