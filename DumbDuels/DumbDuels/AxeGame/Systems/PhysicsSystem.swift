//
//  PhysicsSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class PhysicsSystem: System {
    unowned var entityManager: EntityManager

    var scene: GameScene
    private let physics: Assemblage4<PositionComponent, RotationComponent, PhysicsComponent, CollidableComponent>

    init(for entityManager: EntityManager, scene: GameScene) {
        self.entityManager = entityManager
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
                // TODO: important change this back
                positionComponent.position = CGPoint(x: physicsBody.position.x,
                                                     y: physicsBody.position.y)
            }
            if let rotationComponent: RotationComponent = entityManager.getComponent(ofType: RotationComponent.typeId, for: EntityID(id)) {
                rotationComponent.angleInRadians = physicsBody.zRotation
            }
        }
    }

    func apply(impulse: CGVector, to entityId: EntityID) {
        print("Physics system trying to add impulse \(impulse) to physics component of \(entityId.id)")
        guard let physicsComponent: PhysicsComponent =
                entityManager.getComponent(ofType: PhysicsComponent.typeId, for: entityId) else {
            return
        }
        physicsComponent.impulse = impulse
        print("Physics system added impulse \(impulse) to physics component of \(entityId.id)")
    }

    func syncToPhysicsEngine() {
        for (entity, position, rotation, physics, collidable) in physics.entityAndComponents {
            var physicsBody = initializePhysicsBodyFrom(positionComponent: position,
                                                        rotationComponent: rotation,
                                                        physicsComponent: physics,
                                                        collidableComponent: collidable)
            scene.sync(physicsBody, for: entity.id.id)
            if physics.impulse != .zero {
                scene.apply(impulse: physics.impulse, to: entity.id.id)
                print("Physics systems called scene to add impulse \(physics.impulse) to \(entity.id.id)")
                physics.impulse = .zero
            }
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
        let categoryBitMask = CollisionUtils.bitmasks(for: collidableComponent.categories)
        let collisionBitMask = CollisionUtils.collideBitmasks(for: collidableComponent.categories)
        let contactBitMask = CollisionUtils.contactBitmasks(for: collidableComponent.categories)
        let physicsBody: PhysicsBody = PhysicsBody(position: positionComponent.position,
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
                                                   contactBitMask: contactBitMask)!
        // TODO: take out the force unwrap above?
        return physicsBody
    }

    func getPosition(of entityId: String) -> CGPoint? {
        // MUST be node.
        scene.getPosition(of: entityId)
    }

    func getBitmasks(of entityId: String) -> String {
        "\(scene.getBitMasks(of: entityId))"
    }
}
