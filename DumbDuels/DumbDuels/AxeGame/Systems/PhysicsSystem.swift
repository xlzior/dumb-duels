//
//  PhysicsSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class PhysicsSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    var scene: GameScene
    private let physics: Assemblage3<PositionComponent, RotationComponent, PhysicsComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer, scene: GameScene) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.scene = scene
        self.physics = entityManager.assemblage(requiredComponents:
                                                    PositionComponent.self,
                                                    RotationComponent.self,
                                                    PhysicsComponent.self)
        self.setUpPhysics()
    }

    func update() {
        syncToPhysicsEngine()
    }

    func syncFromPhysicsEngine() {
        for (id, physicsBody) in scene.bodyIDPhysicsMap {
            if let physicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: EntityID(id)) {
                physicsComponent.velocity = physicsBody.velocity
                physicsComponent.mass = physicsBody.mass
                physicsComponent.zRotation = physicsBody.zRotation
            }
            if let positionComponent: PositionComponent =
                entityManager.getComponent(ofType: PositionComponent.typeId, for: EntityID(id)) {
                positionComponent.position = physicsBody.position
            }
            if let rotationComponent: RotationComponent =
                entityManager.getComponent(ofType: RotationComponent.typeId, for: EntityID(id)) {
                rotationComponent.angleInRadians = physicsBody.zRotation
            }
        }
    }

    func apply(impulse: CGVector, to entityId: EntityID) {
        guard let physicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: entityId) else {
            return
        }
        physicsComponent.impulse = impulse
    }

    func syncToPhysicsEngine() {
        for (entity, position, rotation, physics) in physics.entityAndComponents {
            guard !physics.toBeRemoved else {
                scene.removeBody(for: entity.id.id)
                entityManager.remove(componentType: PhysicsComponent.typeId, from: entity.id)
                continue
            }
            if let physicsBody = initializePhysicsBodyFrom(positionComponent: position,
                                                           rotationComponent: rotation,
                                                           physicsComponent: physics) {
                scene.sync(physicsBody, for: entity.id.id)
            } else {
                assertionFailure("Error creating PhysicsBody when syncing to physics engine.")
            }
            if physics.impulse != .zero {
                scene.apply(impulse: physics.impulse, to: entity.id.id)
                physics.impulse = .zero
            }
        }
    }

    func setUpPhysics() {
        var entityIDPhysicsBodyMap = [EntityID.ID: PhysicsBody]()
        for (entity, position, rotation, physics) in physics.entityAndComponents {
            if let physicsBody = initializePhysicsBodyFrom(positionComponent: position,
                                                           rotationComponent: rotation,
                                                           physicsComponent: physics) {
                entityIDPhysicsBodyMap[entity.id.id] = physicsBody
            } else {
                assertionFailure("Error creating PhysicsBody when setting up PhysicsSystem.")
            }
        }
        self.scene.setup(newBodyIDPhysicsMap: entityIDPhysicsBodyMap)
    }

    private func initializePhysicsBodyFrom(positionComponent: PositionComponent,
                                           rotationComponent: RotationComponent,
                                           physicsComponent: PhysicsComponent) -> PhysicsBody? {
        let categoryBitMask = CollisionUtils.bitmasks(for: physicsComponent.categories)
        let collisionBitMask = CollisionUtils.collideBitmasks(for: physicsComponent.categories)
        let contactBitMask = CollisionUtils.contactBitmasks(for: physicsComponent.categories)
        let physicsBody = PhysicsBody(position: positionComponent.position,
                                                    size: physicsComponent.size,
                                                    radius: physicsComponent.radius,
                                                    zRotation: rotationComponent.angleInRadians,
                                                    mass: physicsComponent.mass,
                                                    velocity: physicsComponent.velocity,
                                                    affectedByGravity: physicsComponent.affectedByGravity,
                                                    linearDamping: physicsComponent.linearDamping,
                                                    isDynamic: physicsComponent.isDynamic,
                                                    allowsRotation: physicsComponent.allowsRotation,
                                                    restitution: physicsComponent.restitution,
                                                    friction: physicsComponent.friction,
                                                    categoryBitMask: categoryBitMask,
                                                    collisionBitMask: collisionBitMask,
                                                    contactBitMask: contactBitMask)
        return physicsBody
    }

    func handleCollision(firstId: String, secondId: String) {
        let firstEid = EntityID(firstId)
        let secondEid = EntityID(secondId)
        guard let firstPhysicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: firstEid),
              let secondPhysicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: secondEid) else {
            return
        }
        for firstCategory in firstPhysicsComponent.categories {
            for secondCategory in secondPhysicsComponent.categories {
                if let collisionEvent = firstCategory.collides(with: secondCategory) {
                    eventFirer.fire(collisionEvent)
                }
            }
        }
    }
}
