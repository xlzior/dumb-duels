//
//  AutoRotateSystem.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 27/3/23.
//

class AutoRotateSystem: System {
    unowned var entityManager: EntityManager
    private var objects: Assemblage2<RotationComponent, AutoRotateComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.objects = entityManager.assemblage(requiredComponents: RotationComponent.self, AutoRotateComponent.self)
    }

    func update() {
        for (rotation, autoRotate) in objects {
            rotation.angleInRadians = (rotation.angleInRadians + autoRotate.anglePerLoop)
                .truncatingRemainder(dividingBy: 2 * Double.pi)
        }
    }
}
