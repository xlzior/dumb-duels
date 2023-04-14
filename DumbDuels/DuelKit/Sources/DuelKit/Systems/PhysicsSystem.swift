//
//  PhysicsSystem.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

public class PhysicsSystem: System {
    public typealias ContactHandlerMap = [Pair<UInt32, UInt32>: (EntityID, EntityID) -> Event]
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    var scene: Scene
    private let physics: Assemblage3<PositionComponent, RotationComponent, PhysicsComponent>
    private let oscillation: Assemblage1<OscillationComponent>
    private let contactHandlers: ContactHandlerMap

    init(for entityManager: EntityManager, eventFirer: EventFirer,
         scene: Scene, contactHandlers: ContactHandlerMap) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.scene = scene
        self.physics = entityManager.assemblage(
            requiredComponents: PositionComponent.self, RotationComponent.self, PhysicsComponent.self)
        self.oscillation = entityManager.assemblage(requiredComponents: OscillationComponent.self)
        self.contactHandlers = contactHandlers

        self.setUpPhysics()
    }

    public func update() {
        syncToPhysicsEngine()
    }

    func syncFromPhysicsEngine() {
        scene.forEachEntity(perform: { id, physicsSimulatableBody in
            if let physicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: id) {
                physicsComponent.velocity = physicsSimulatableBody.velocity
                physicsComponent.mass = physicsSimulatableBody.mass
                physicsComponent.zRotation = physicsSimulatableBody.zRotation
                physicsComponent.ownBitmask = physicsSimulatableBody.categoryBitMask
                physicsComponent.contactBitmask = physicsSimulatableBody.contactTestBitMask
                physicsComponent.collideBitmask = physicsSimulatableBody.collisionBitMask
            }
            if let positionComponent: PositionComponent =
                entityManager.getComponent(ofType: PositionComponent.typeId, for: id) {
                positionComponent.position = physicsSimulatableBody.position
            }
            if let rotationComponent: RotationComponent =
                entityManager.getComponent(ofType: RotationComponent.typeId, for: id) {
                rotationComponent.angleInRadians = physicsSimulatableBody.zRotation
            }
        })
    }

    func apply(impulse: CGVector, to entityId: EntityID) {
        guard let physicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: entityId) else {
            return
        }
        physicsComponent.impulse = impulse
    }

    func apply(angularImpulse: CGFloat, to entityId: EntityID) {
        guard let physicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: entityId) else {
            return
        }
        physicsComponent.angularImpulse = angularImpulse
    }

    func syncToPhysicsEngine() {
        for (entity, position, rotation, physics) in physics.entityAndComponents {
            guard !physics.toBeRemoved else {
                scene.removePhysicsSimulatableBody(for: entity.id)
                entityManager.remove(componentType: PhysicsComponent.typeId, from: entity.id)
                if physics.shouldDestroyEntityWhenRemove {
                    entityManager.destroy(entity: entity)
                }
                continue
            }
            if var physicsSimulatableBody = scene.getPhysicsSimulatableBody(for: entity.id) {
                update(for: &physicsSimulatableBody, positionComponent: position,
                       rotationComponent: rotation, physicsComponent: physics)
            } else {
                createSimulatablePhysicsBody(for: entity.id,
                                             positionComponent: position,
                                             rotationComponent: rotation,
                                             physicsComponent: physics)
            }
            if physics.impulse != .zero {
                scene.apply(impulse: physics.impulse, to: entity.id)
                physics.impulse = .zero
            }
            if physics.angularImpulse != .zero {
                scene.apply(angularImpulse: physics.angularImpulse, to: entity.id)
                physics.angularImpulse = .zero
            }
        }
    }

    func setUpPhysics() {
        for (entity, position, rotation, physics) in physics.entityAndComponents {
            createSimulatablePhysicsBody(for: entity.id,
                                         positionComponent: position,
                                         rotationComponent: rotation,
                                         physicsComponent: physics)
        }
        for (entity, oscillation) in oscillation.entityAndComponents {
            scene.beginOscillation(for: entity.id, at: oscillation.centerOfOscillation, axis: oscillation.axis,
                                   amplitude: oscillation.amplitude, period: oscillation.period,
                                   displacement: oscillation.displacement)
        }
    }

    private func update(for physicsSimulatableBody: inout PhysicsSimulatableBody,
                        positionComponent: PositionComponent,
                        rotationComponent: RotationComponent,
                        physicsComponent: PhysicsComponent) {
        physicsSimulatableBody.position = positionComponent.position
        physicsSimulatableBody.zRotation = rotationComponent.angleInRadians
        physicsSimulatableBody.mass = physicsComponent.mass
        physicsSimulatableBody.velocity = physicsComponent.velocity
        physicsSimulatableBody.affectedByGravity = physicsComponent.affectedByGravity
        physicsSimulatableBody.linearDamping = physicsComponent.linearDamping
        physicsSimulatableBody.isDynamic = physicsComponent.isDynamic
        physicsSimulatableBody.allowsRotation = physicsComponent.allowsRotation
        physicsSimulatableBody.restitution = physicsComponent.restitution
        physicsSimulatableBody.friction = physicsComponent.friction
        physicsSimulatableBody.categoryBitMask = physicsComponent.ownBitmask
        physicsSimulatableBody.collisionBitMask = physicsComponent.collideBitmask
        physicsSimulatableBody.contactTestBitMask = physicsComponent.contactBitmask
    }

    private func createSimulatablePhysicsBody(for id: EntityID,
                                              positionComponent: PositionComponent,
                                              rotationComponent: RotationComponent,
                                              physicsComponent: PhysicsComponent) {
        var physicsSimulatableBody: PhysicsSimulatableBody?
        if physicsComponent.shape == .circle, let radius = physicsComponent.radius {
            physicsSimulatableBody = scene.createCirclePhysicsSimulatableBody(for: id,
                                                                              withRadius: radius,
                                                                              at: positionComponent.position)
        } else if physicsComponent.shape == .rectangle, let size = physicsComponent.size {
            physicsSimulatableBody = scene.createRectanglePhysicsSimulatableBody(for: id,
                                                                                 withSize: size,
                                                                                 at: positionComponent.position)
        }

        if var physicsSimulatableBody = physicsSimulatableBody {
            update(for: &physicsSimulatableBody, positionComponent: positionComponent,
                   rotationComponent: rotationComponent, physicsComponent: physicsComponent)
        }
    }

    func handleCollision(firstId: EntityID, secondId: EntityID) {
        guard let firstPhysicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: firstId),
              let secondPhysicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: secondId) else {
            return
        }

        let firstCategory = firstPhysicsComponent.ownBitmask
        let secondCategory = secondPhysicsComponent.ownBitmask
        let key = Pair(first: firstCategory, second: secondCategory)
        if let eventProducer = contactHandlers[key] {
            let event = eventProducer(firstId, secondId)
            eventFirer.fire(event)
        }
    }
}
