//
//  InputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class InputSystem: System {
    unowned var entityManager: EntityManager
    private var physicsCreator: PhysicsCreator

    private var holdingAxePlayer: Assemblage4<PlayerComponent, PositionComponent, HoldingAxeComponent, WithThrowStrengthComponent>
    private var unthrownAxe: Assemblage2<AxeComponent, SizeComponent>
    private var canJumpPlayer: Assemblage3<PlayerComponent, CanJumpComponent, PhysicsComponent>
    private var throwStrength: Assemblage2<ThrowStrengthComponent, SizeComponent>

    private var isLongPressed = Set<EntityID>()

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = PhysicsCreator(entityManager: entityManager)
        self.holdingAxePlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, PositionComponent.self,
            HoldingAxeComponent.self, WithThrowStrengthComponent.self)
        self.unthrownAxe = entityManager.assemblage(requiredComponents: AxeComponent.self, SizeComponent.self,
                                                    excludedComponents: PhysicsComponent.self)
        self.canJumpPlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, CanJumpComponent.self, PhysicsComponent.self)
        self.throwStrength = entityManager.assemblage(
            requiredComponents: ThrowStrengthComponent.self, SizeComponent.self)
    }

    func update() {
        for entityId in isLongPressed {
            updateThrowStrength(for: entityId)
        }
    }

    func updateThrowStrength(for entityId: EntityID) {
        guard let (_, _, _, withThrowStrength) = holdingAxePlayer.getComponents(for: entityId),
              let (throwStrengthComponent, sizeComponent) = throwStrength.getComponents(
                for: withThrowStrength.throwStrengthEntityId) else {
            return
        }

        throwStrengthComponent.fsm.changeState(name: .charging)

        if throwStrengthComponent.throwStrength <= Constants.minimumThrowStrength {
            throwStrengthComponent.multiplier = 1
        }

        if throwStrengthComponent.throwStrength >= Constants.maximumThrowStrength {
            throwStrengthComponent.multiplier = -1
        }

        throwStrengthComponent.throwStrength += throwStrengthComponent.multiplier
                                                * Constants.throwStrengthChangeRate
        sizeComponent.xScale = throwStrengthComponent.throwStrength
    }

    func handleButtonDown(entityId: EntityID) {
        let hasAxe = entityManager.has(componentTypeId: HoldingAxeComponent.typeId, entityId: entityId)

        if hasAxe {
            isLongPressed.insert(entityId)
            updateThrowStrength(for: entityId)
        } else {
            jump(playerId: entityId)
        }
    }

    func handleButtonUp(entityId: EntityID) {
        isLongPressed.remove(entityId)
        throwAxe(for: entityId)
    }

    func throwAxe(for playerId: EntityID) {
        guard let (player, playerPosition, holdingAxe, withThrowStrength) = holdingAxePlayer.getComponents(for: playerId),
              let (_, axeSize) = unthrownAxe.getComponents(for: holdingAxe.axeEntityID) else {
            return
        }
        let axeId = holdingAxe.axeEntityID
        let towards = playerPosition.faceDirection

        let physicsCreator = PhysicsCreator(entityManager: entityManager)
        let physicsComponent = physicsCreator.createAxe(of: axeSize.actualSize, for: axeId)
        entityManager.assign(component: physicsComponent, to: axeId)

        guard let throwStrengthComponent: ThrowStrengthComponent = entityManager.getComponent(
            ofType: ThrowStrengthComponent.typeId,
            for: withThrowStrength.throwStrengthEntityId) else {
            return
        }

        throwStrengthComponent.fsm.changeState(name: .notCharging)
        let throwStrength = throwStrengthComponent.throwStrength
        physicsComponent.impulse = CGVector(dx: towards.rawValue * throwStrength * Constants.throwForce.dx,
                                            dy: throwStrength * Constants.throwForce.dy)
        player.fsm.changeState(name: .notHoldingAxe)
    }

    func jump(playerId: EntityID) {
        guard let (_, canJump, physics) = canJumpPlayer.getComponents(for: playerId) else {
            return
        }
        physics.impulse += Constants.jumpForce
        canJump.jumpsLeft -= 1
        if canJump.jumpsLeft <= 0 {
            entityManager.remove(componentType: CanJumpComponent.typeId, from: playerId)
        }
    }
}
