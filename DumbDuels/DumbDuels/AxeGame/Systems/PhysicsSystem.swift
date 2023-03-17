//
//  PhysicsSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class PhysicsSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventManager: EventManager

    var scene: GameScene
    private let physics: Assemblage4<PositionComponent, RotationComponent, PhysicsComponent, CollidableComponent>

    init(for entityManager: EntityManager, eventManger: EventManager, scene: GameScene) {
        self.entityManager = entityManager
        self.eventManager = eventManger
        self.scene = scene
        self.physics = entityManager.assemblage(requiredComponents:
                                                    PositionComponent.self,
                                                    RotationComponent.self,
                                                    PhysicsComponent.self,
                                                    CollidableComponent.self)
        self.setUpPhysics()
    }

    func update() {
        syncToPhysicsEngine()
    }

    func syncFromPhysicsEngine() {
        for (id, physicsBody) in scene.bodyIDPhysicsMap {
            if let physicsComponent: PhysicsComponent = entityManager.getComponent(ofType: PhysicsComponent.typeId, for: EntityID(id)) {
                physicsComponent.velocity = physicsBody.velocity
                physicsComponent.mass = physicsBody.mass
                physicsComponent.zRotation = physicsBody.zRotation
            }
            if let positionComponent: PositionComponent = entityManager.getComponent(ofType: PositionComponent.typeId, for: EntityID(id)) {
                positionComponent.position = physicsBody.position
            }
            if let rotationComponent: RotationComponent = entityManager.getComponent(ofType: RotationComponent.typeId, for: EntityID(id)) {
                rotationComponent.angleInRadians = physicsBody.zRotation
            }
        }
    }

    func apply(impulse: CGVector, to entityId: EntityID) {
        scene.apply(impulse: impulse, to: entityId.id)
    }

    func syncToPhysicsEngine() {
        for (entity, position, rotation, physics, collidable) in physics.entityAndComponents {
            var physicsBody = initializePhysicsBodyFrom(positionComponent: position,
                                                        rotationComponent: rotation,
                                                        physicsComponent: physics,
                                                        collidableComponent: collidable)
            scene.sync(physicsBody, for: entity.id.id)
        }
    }

    func setUpPhysics() {
        var entityIDPhysicsBodyMap = [EntityID.ID: PhysicsBody]()
        for (entity, position, rotation, physics, collidable) in physics.entityAndComponents {
            var physicsBody = initializePhysicsBodyFrom(positionComponent: position,
                                                        rotationComponent: rotation,
                                                        physicsComponent: physics,
                                                        collidableComponent: collidable)
            entityIDPhysicsBodyMap[entity.id.id] = physicsBody
        }
        self.scene.setup(newBodyIDPhysicsMap: entityIDPhysicsBodyMap)
    }

    private func initializePhysicsBodyFrom(positionComponent: PositionComponent,
                                           rotationComponent: RotationComponent,
                                           physicsComponent: PhysicsComponent,
                                           collidableComponent: CollidableComponent) -> PhysicsBody {
        let categoryBitMask = CategoryTypeBitMasks.getBitMask(for: collidableComponent.categories)
        let collisionBitMask = CollisionTypeBitMasks.getBitMask(for: collidableComponent.collisions)
        let contactBitMask = ContactTestTypeBitMasks.getBitMask(for: collidableComponent.contacts)
        var physicsBody: PhysicsBody = PhysicsBody(position: positionComponent.position,
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
}
