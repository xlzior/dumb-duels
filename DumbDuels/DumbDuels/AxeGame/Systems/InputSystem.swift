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

    private var holdingAxePlayer: Assemblage2<PlayerComponent, HoldingAxeComponent>
    private var unthrownAxe: Assemblage2<AxeComponent, SizeComponent>
    private var canJumpPlayer: Assemblage3<PlayerComponent, CanJumpComponent, PhysicsComponent>

    private var throwStrength: CGFloat = 1.0

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.physicsCreator = PhysicsCreator(entityManager: entityManager)
        self.holdingAxePlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self,
                                                         HoldingAxeComponent.self)
        self.unthrownAxe = entityManager.assemblage(requiredComponents: AxeComponent.self, SizeComponent.self,
                                                    excludedComponents: PhysicsComponent.self)
        self.canJumpPlayer = entityManager.assemblage(
            requiredComponents: PlayerComponent.self, CanJumpComponent.self, PhysicsComponent.self)
    }

    func update() {

    }

    func handleButtonPress(entityId: EntityID) {
        guard let playerPosition: PositionComponent = entityManager.getComponent(
            ofType: PositionComponent.typeId,
            for: entityId) else {
            return
        }
        let playerFacing = playerPosition.faceDirection

        let hasAxe = entityManager.has(componentTypeId: HoldingAxeComponent.typeId, entityId: entityId)

        if !hasAxe {
            return jump(playerId: entityId)
        }

        guard let holdingAxe: HoldingAxeComponent = entityManager.getComponent(
            ofType: HoldingAxeComponent.typeId,
            for: entityId) else {
            return
        }
        throwsAxe(axeId: holdingAxe.axeEntityID, by: entityId, towards: playerFacing)
    }

    func handleButtonLongPress(entityId: EntityID) {
        // TODO(sprint2): charge the axe by modifying the throwStrength variable
    }

    func throwsAxe(axeId: EntityID, by playerId: EntityID, towards: FaceDirection) {
        guard let (_, axeSize) = unthrownAxe.getComponents(for: axeId),
              let (player, _) = holdingAxePlayer.getComponents(for: playerId) else {
            return
        }
        let physicsCreator = PhysicsCreator(entityManager: entityManager)
        let physicsComponent = physicsCreator.createAxe(of: axeSize.actualSize, for: axeId)
        entityManager.assign(component: physicsComponent, to: axeId)
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
