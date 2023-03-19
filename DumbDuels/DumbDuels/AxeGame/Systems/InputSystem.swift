//
//  InputSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class InputSystem: System {
    unowned var entityManager: EntityManager

    private var holdingAxePlayer: Assemblage2<PlayerComponent, HoldingAxeComponent>
    private var axe: Assemblage2<AxeComponent, PhysicsComponent>
    private var canJumpPlayer: Assemblage3<PlayerComponent, CanJumpComponent, PhysicsComponent>

    private var throwStrength: CGFloat = 1.0

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.holdingAxePlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self,
                                                         HoldingAxeComponent.self)
        self.axe = entityManager.assemblage(requiredComponents: AxeComponent.self, PhysicsComponent.self)
        self.canJumpPlayer = entityManager.assemblage(requiredComponents: PlayerComponent.self, CanJumpComponent.self, PhysicsComponent.self)
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
        // TODO: charge the axe
    }

    func throwsAxe(axeId: EntityID, by playerId: EntityID, towards: FaceDirection) {
        guard entityManager.isMember(playerId, ofAssemblageWithTraits: holdingAxePlayer.traits),
              entityManager.isMember(axeId, ofAssemblageWithTraits: axe.traits),
              let physicsComponent: PhysicsComponent = entityManager.getComponent(for: axeId) else {
            assertionFailure("Throw axe failed for playerId \(playerId) and axeId \(axeId)")
            return
        }
        physicsComponent.impulse = CGVector(dx: towards.rawValue * throwStrength * Constants.throwForce.dx,
                                            dy: throwStrength * Constants.throwForce.dy)
        physicsComponent.affectedByGravity = true
        entityManager.remove(componentType: HoldingAxeComponent.typeId, from: playerId)
    }

    func jump(playerId: EntityID) {
        guard entityManager.isMember(playerId, ofAssemblageWithTraits: canJumpPlayer.traits),
              let physicsComponent: PhysicsComponent = entityManager.getComponent(for: playerId),
              let canJumpComponent: CanJumpComponent = entityManager.getComponent(for: playerId) else {
            print("Player \(playerId) cannot jump")
            return
        }
        physicsComponent.impulse += Constants.jumpForce
        canJumpComponent.jumpsLeft -= 1
        if canJumpComponent.jumpsLeft <= 0 {
            entityManager.remove(componentType: CanJumpComponent.typeId, from: playerId)
        }
    }
}
