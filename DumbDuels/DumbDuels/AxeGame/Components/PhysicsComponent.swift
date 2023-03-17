//
//  PhysicsComponent.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

class PhysicsComponent: Component {
    enum Shape {
        case circle
        case rectangle
    }

    // TODO: Store radius or CGSize depending on rectangle or circle shape
    var id: ComponentID
    var shape: Shape
    var radius: CGFloat?
    var size: CGSize?
    var mass: CGFloat
    var velocity: CGVector
    var affectedByGravity: Bool
    var linearDamping: CGFloat
    var isDynamic: Bool
    var allowsRotation: Bool
    var restitution: CGFloat
    var friction: CGFloat
    var zRotation: CGFloat

    private init?(shape: Shape, radius: CGFloat? = nil, size: CGSize? = nil,
                 mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                 linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                 restitution: CGFloat, friction: CGFloat, categoryBitMask: UInt32,
                 collisionBitMask: UInt32, contactTestBitMask: UInt32, zRotation: CGFloat) {
        guard (size == nil && radius != nil) || (size != nil && radius == nil) else {
            assertionFailure("Please pass in only either a size to initialize a rectangle physics component or a radius to initialize a circle physics component")
            return nil
        }
        self.id = ComponentID()
        self.shape = shape
        self.radius = radius
        self.size = size
        self.mass = mass
        self.velocity = velocity
        self.affectedByGravity = affectedByGravity
        self.linearDamping = linearDamping
        self.isDynamic = isDynamic
        self.allowsRotation = allowsRotation
        self.restitution = restitution
        self.friction = friction
        self.zRotation = zRotation
        // TODO: assert is valid
//        assert()
    }

    convenience init(radius: CGFloat,
                     mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                     linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                     restitution: CGFloat, friction: CGFloat, categoryBitMask: UInt32,
                     collisionBitMask: UInt32, contactTestBitMask: UInt32, zRotation: CGFloat) {
        self.init(shape: .circle, radius: radius, mass: mass,
                  velocity: velocity, affectedByGravity: affectedByGravity, linearDamping: linearDamping,
                  isDynamic: isDynamic, allowsRotation: allowsRotation, restitution: restitution,
                  friction: friction, categoryBitMask: categoryBitMask, collisionBitMask: collisionBitMask,
                  contactTestBitMask: contactTestBitMask, zRotation: zRotation)!
    }

    convenience init(size: CGSize,
                     mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                     linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                     restitution: CGFloat, friction: CGFloat, categoryBitMask: UInt32,
                     collisionBitMask: UInt32, contactTestBitMask: UInt32, zRotation: CGFloat) {
        self.init(shape: .rectangle, size: size, mass: mass,
                  velocity: velocity, affectedByGravity: affectedByGravity, linearDamping: linearDamping,
                  isDynamic: isDynamic, allowsRotation: allowsRotation, restitution: restitution,
                  friction: friction, categoryBitMask: categoryBitMask, collisionBitMask: collisionBitMask,
                  contactTestBitMask: contactTestBitMask, zRotation: zRotation)!
    }

//    func isValid() -> Bool {
//        // TODO: make sure it if shape is cirlce then it must have radius
//        // TODO: and if shape is rectangle then must have size
//        // other stuff, not so importabt: e.g. restitution between >= 0 and <= 1
//
//    }
}
