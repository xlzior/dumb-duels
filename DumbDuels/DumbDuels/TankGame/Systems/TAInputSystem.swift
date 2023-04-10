//
//  TAInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import Foundation
import DuelKit

class TAInputSystem {
    var playerIndexToIdMap = [Int: EntityID]()

    var entityManager: EntityManager
    var entityCreator: TAEntityCreator
    var tanks: Assemblage5<TankComponent, PositionComponent, RotationComponent, PhysicsComponent, SoundComponent>

    init(for entityManager: EntityManager, entityCreator: TAEntityCreator) {
        self.entityManager = entityManager
        self.entityCreator = entityCreator
        self.tanks = entityManager.assemblage(
            requiredComponents: TankComponent.self, PositionComponent.self,
            RotationComponent.self, PhysicsComponent.self, SoundComponent.self)
    }

    private func fireCannonball(at position: CGPoint, of size: CGSize,
                                direction: CGFloat, firedBy playerId: EntityID) {
        entityCreator.createCannonball(
            at: position, of: size, direction: direction,
            expiring: Date().addingTimeInterval(TAConstants.cannonballLifespan),
            firedBy: playerId,
            immunityUntil: Date().addingTimeInterval(TAConstants.cannonballImmunityInterval))
    }
}

// TODO: (WJ) I don't like this, I don't think it makes sense
extension TAInputSystem {
    func setPlayerId(firstPlayer: EntityID, secondPlayer: EntityID) {
        playerIndexToIdMap[0] = firstPlayer
        playerIndexToIdMap[1] = secondPlayer
    }
}

extension TAInputSystem: InputSystem {
    func update() {
        for (entity, tank, position, rotation, physics, sound) in tanks.entityAndComponents {
            if tank.isMoving {
                sound.sounds[TASoundTypes.tankEngine]?.play()
            }

            // after getting pushed by the other tank, velocity goes weird
            physics.velocity = tank.isMoving
                ? TAConstants.movingSpeed * CGVector(angle: rotation.angleInRadians)
                : .zero

            if let chargingSince = tank.chargingSince {
                let chargingTime = Date().timeIntervalSince(chargingSince)
                let chargingStage = ceil(chargingTime / TAConstants.chargingTime)

                if chargingStage > 3 {
                    tank.fsm.changeState(name: .charging0)
                    tank.chargingState = 0
                    tank.chargingSince = nil
                    let direction = CGVector(angle: rotation.angleInRadians)
                    let offset = (TASizes.cannonball.width / 2 + 1 + TASizes.tank.width / 2)
                    let cannonPosition = position.position + offset * direction
                    physics.impulse = -TAConstants.recoilForce * direction
                    fireCannonball(at: cannonPosition, of: TASizes.cannonball,
                                   direction: rotation.angleInRadians, firedBy: entity.id)
                    sound.sounds[TASoundTypes.tankShoot]?.play()
                } else if chargingStage > 2 && tank.chargingState < 2 {
                    tank.fsm.changeState(name: .charging2)
                    tank.chargingState = 2
                    sound.sounds[TASoundTypes.tankBeep]?.play()
                } else if chargingStage > 1 && tank.chargingState < 1 {
                    tank.fsm.changeState(name: .charging1)
                    tank.chargingState = 1
                    sound.sounds[TASoundTypes.tankBeep]?.play()
                }
            }
        }
    }

    func handleButtonDown(playerIndex: Int) {
        guard let tankId = playerIndexToIdMap[playerIndex],
              let (tank, _, rotation, physics, _) = tanks.getComponents(for: tankId) else {
            return
        }

        tank.isMoving = true
        tank.chargingSince = Date()
        entityManager.remove(componentType: AutoRotateComponent.typeId, from: tankId)

        physics.velocity = TAConstants.movingSpeed * CGVector(angle: rotation.angleInRadians)
    }

    func handleButtonUp(playerIndex: Int) {
        guard let tankId = playerIndexToIdMap[playerIndex],
              let (tank, tankData, _, _, physics, _) = tanks.getEntityAndComponents(for: tankId) else {
            return
        }

        tankData.fsm.changeState(name: .charging0)
        tankData.chargingState = 0
        tankData.isMoving = false
        tankData.chargingSince = nil
        tankData.rotationDirection *= -1
        tank.assign(component: AutoRotateComponent(by: tankData.rotationDirection * TAConstants.rotationSpeed))
        physics.velocity = .zero
    }
}
