//
//  AXInputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import Foundation
import CoreGraphics
import DuelKit

class AXInputSystem {
    unowned var entityManager: EntityManager
    private var physicsCreator: AXPhysicsCreator

    var playerIndexToIdMap: [Int: EntityID]

    private var holdingAxePlayer: Assemblage4<PlayerComponent, PositionComponent,
                                              HoldingAxeComponent, WithThrowStrengthComponent>
    private var unthrownAxe: Assemblage3<AxeComponent, SizeComponent, SyncXPositionComponent>
    private var canJumpPlayer: Assemblage4<PlayerComponent, CanJumpComponent, PhysicsComponent, SoundComponent>
    private var throwStrength: Assemblage2<ThrowStrengthComponent, SizeComponent>

    private var longPressStartTimes = [EntityID: Date]()

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = AXPhysicsCreator()
        self.holdingAxePlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PositionComponent.self,
            HoldingAxeComponent.self, WithThrowStrengthComponent.self)
        self.unthrownAxe = entityManager.assemblage(requiredComponents: AxeComponent.self,
                                                    SizeComponent.self, SyncXPositionComponent.self,
                                                    excludedComponents: PhysicsComponent.self)
        self.canJumpPlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self,
                                                      CanJumpComponent.self, PhysicsComponent.self,
                                                      SoundComponent.self)
        self.throwStrength = entityManager.assemblage(
            requiredComponents: ThrowStrengthComponent.self, SizeComponent.self)
        self.playerIndexToIdMap = [Int: EntityID]()
    }

    func updateThrowStrength(for entityId: EntityID) {
        guard let longPressStarted = longPressStartTimes[entityId],
              let (_, _, _, withThrowStrength) = holdingAxePlayer.getComponents(for: entityId),
              let (throwStrengthComponent, sizeComponent) = throwStrength.getComponents(
                for: withThrowStrength.throwStrengthEntityId) else {
            return
        }

        throwStrengthComponent.fsm.changeState(name: .charging)

        let now = Date()
        let timeElapsed = (now - longPressStarted).truncatingRemainder(dividingBy: 2 * AXConstants.chargingTime)
        let throwStrengthRange = AXConstants.maximumThrowStrength - AXConstants.minimumThrowStrength
        let newThrowStrength = timeElapsed < AXConstants.chargingTime
            ? AXConstants.minimumThrowStrength + timeElapsed / throwStrengthRange
            : AXConstants.maximumThrowStrength + AXConstants.chargingTime - timeElapsed / throwStrengthRange

        throwStrengthComponent.throwStrength = newThrowStrength
        sizeComponent.xScale = newThrowStrength
    }

    func throwAxe(for playerId: EntityID) {
        guard let (player, playerPosition, holdingAxe, withThrowStrength) =
                holdingAxePlayer.getComponents(for: playerId),
              let (_, axeSize, _) = unthrownAxe.getComponents(for: holdingAxe.axeEntityID) else {
            return
        }
        let axeId = holdingAxe.axeEntityID
        entityManager.remove(componentType: SyncXPositionComponent.typeId, from: axeId)

        let towards = playerPosition.faceDirection

        let physicsCreator = AXPhysicsCreator()
        let physicsComponent = physicsCreator.createAxe(of: axeSize.actualSize)
        entityManager.assign(component: physicsComponent, to: axeId)

        guard let throwStrengthComponent: ThrowStrengthComponent = entityManager.getComponent(
            ofType: ThrowStrengthComponent.typeId,
            for: withThrowStrength.throwStrengthEntityId) else {
            return
        }

        throwStrengthComponent.fsm.changeState(name: .notCharging)
        let throwStrength = throwStrengthComponent.throwStrength
        physicsComponent.impulse = CGVector(dx: towards.rawValue * throwStrength * AXConstants.throwForce.dx,
                                            dy: throwStrength * AXConstants.throwForce.dy)
        physicsComponent.angularImpulse = towards == .right
            ? AXConstants.throwAngularForce
            : -AXConstants.throwAngularForce
        entityManager.remove(componentType: HoldingAxeComponent.typeId, from: playerId)
    }

    func jump(playerId: EntityID) {
        guard let (_, canJump, physics, sound) = canJumpPlayer.getComponents(for: playerId) else {
            return
        }
        physics.impulse += AXConstants.jumpForce
        canJump.jumpsLeft -= 1
        sound.sounds[AXSoundTypes.playerJump]?.play()
        if canJump.jumpsLeft <= 0 {
            entityManager.remove(componentType: CanJumpComponent.typeId, from: playerId)
        }
    }

    func setPlayerId(firstPlayer: EntityID, secondPlayer: EntityID) {
        playerIndexToIdMap[0] = firstPlayer
        playerIndexToIdMap[1] = secondPlayer
    }
}

extension AXInputSystem: InputSystem {

    func update() {
        for entityId in longPressStartTimes.keys {
            updateThrowStrength(for: entityId)
        }
    }

    func handleButtonDown(playerIndex: Int) {
        guard let entityId = playerIndexToIdMap[playerIndex] else {
            return
        }

        let hasAxe = entityManager.has(componentTypeId: HoldingAxeComponent.typeId, entityId: entityId)

        if hasAxe {
            longPressStartTimes[entityId] = Date()
            updateThrowStrength(for: entityId)
        } else {
            jump(playerId: entityId)
        }
    }

    func handleButtonUp(playerIndex: Int) {
        guard let entityId = playerIndexToIdMap[playerIndex] else {
            return
        }
        longPressStartTimes[entityId] = nil
        throwAxe(for: entityId)
    }
}
