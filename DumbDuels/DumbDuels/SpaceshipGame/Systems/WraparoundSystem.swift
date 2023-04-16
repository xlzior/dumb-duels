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
        self.objects = entityManager.assemblage(
            requiredComponents: PositionComponent.self, excludedComponents: BulletComponent.self)
    }

    func update() {
        for position in objects where !Sizes.gameRect.contains(position.position) {
            let newX = position.position.x.modulo(Sizes.game.width)
            let newY = position.position.y.modulo(Sizes.game.height)
            position.position = CGPoint(x: newX, y: newY)
        }
    }
}
