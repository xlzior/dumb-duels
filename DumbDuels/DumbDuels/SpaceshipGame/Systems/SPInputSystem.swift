//
//  SPInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPInputSystem: InputSystem {
    unowned var entityManager: EntityManager
    private var spaceships: Assemblage4<SpaceshipComponent, RotationComponent, PhysicsComponent, SoundComponent>

    var playerIndexToIdMap: [Int: EntityID]

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.spaceships = entityManager.assemblage(requiredComponents: SpaceshipComponent.self,
                                                   RotationComponent.self, PhysicsComponent.self, SoundComponent.self)
        self.playerIndexToIdMap = [Int: EntityID]()
    }

    func handleButtonDown(playerIndex: Int) {
        guard let entityId = playerIndexToIdMap[playerIndex],
              let (_, rotation, physics, sound) = spaceships.getComponents(for: entityId) else {
            return
        }

        let angle = CGVector(angle: rotation.angleInRadians)
        // set the velocity directly so there is no drifting
        physics.velocity = SPConstants.propulsionForce * angle
        physics.linearDamping = SPPhysics.spaceshipMovingDamping

        sound.sounds[SPSoundTypes.spaceshipEngine]?.play()

        entityManager.remove(componentType: AutoRotateComponent.typeId, from: entityId)

        DispatchQueue.main.asyncAfter(deadline: .now() + SPConstants.rotationStoppedInterval) {
            guard self.canAssignAutoRotate(entityId: entityId) else {
                return
            }
            self.entityManager.assign(component: AutoRotateComponent(by: SPConstants.rotationSpeed), to: entityId)
            physics.linearDamping = SPPhysics.spaceshipStaticDamping
        }
    }

    func handleButtonUp(playerIndex: Int) {

    }

    func update() {

    }

    func setPlayerId(firstPlayer: EntityID, secondPlayer: EntityID) {
        playerIndexToIdMap[0] = firstPlayer
        playerIndexToIdMap[1] = secondPlayer
    }

    private func canAssignAutoRotate(entityId: EntityID) -> Bool {
        spaceships.isMember(entityId: entityId) &&
        !entityManager.has(componentTypeId: AutoRotateComponent.typeId, entityId: entityId)
    }
}
