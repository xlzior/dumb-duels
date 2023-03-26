//
//  PhysicsComponent.swift
//  DuelKit
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

public class PhysicsComponent: Component {
    enum Shape {
        case circle
        case rectangle
    }

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
    var impulse: CGVector
    var angularImpulse: CGFloat
    var ownBitmask: UInt32
    var collideBitmask: UInt32
    var contactBitmask: UInt32
    var toBeRemoved: Bool

    private init?(shape: Shape, radius: CGFloat? = nil, size: CGSize? = nil,
                  mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                  linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                  restitution: CGFloat, friction: CGFloat, ownBitmask: UInt32,
                  collideBitmask: UInt32, contactBitmask: UInt32,
                  zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat,
                  toBeRemoved: Bool = false) {
        guard (size == nil && radius != nil) || (size != nil && radius == nil) else {
            assertionFailure(
                """
                Please pass in only either a size for a rectangle physics component
                or a radius for a circle physics component
                """
            )
            return nil
        }
        guard mass > 0 else {
            assertionFailure("Mass cannot be negative")
            return nil
        }
        guard linearDamping >= 0 && linearDamping <= 1 else {
            assertionFailure("linearDamping must be a value from 0.0 to 1.0")
            return nil
        }
        guard restitution >= 0 && restitution <= 1 else {
            assertionFailure("restitution must be a value from 0.0 to 1.0")
            return nil
        }
        guard friction >= 0 && linearDamping <= 1 else {
            assertionFailure("friction must be a value from 0.0 to 1.0")
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
        self.impulse = impulse
        self.angularImpulse = angularImpulse
        self.ownBitmask = ownBitmask
        self.collideBitmask = collideBitmask
        self.contactBitmask = contactBitmask
        self.toBeRemoved = toBeRemoved
    }

    convenience init(circleOf radius: CGFloat,
                     mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                     linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                     restitution: CGFloat, friction: CGFloat, ownBitmask: UInt32,
                     collideBitmask: UInt32, contactBitmask: UInt32,
                     zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat) {
        self.init(shape: .circle, radius: radius, size: nil, mass: mass,
                  velocity: velocity, affectedByGravity: affectedByGravity, linearDamping: linearDamping,
                  isDynamic: isDynamic, allowsRotation: allowsRotation, restitution: restitution,
                  friction: friction, ownBitmask: ownBitmask, collideBitmask: collideBitmask,
                  contactBitmask: contactBitmask, zRotation: zRotation, impulse: impulse,
                  angularImpulse: angularImpulse)!
    }

    convenience init(rectangleOf size: CGSize,
                     mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                     linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                     restitution: CGFloat, friction: CGFloat, ownBitmask: UInt32,
                     collideBitmask: UInt32, contactBitmask: UInt32,
                     zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat) {
        self.init(shape: .rectangle, radius: nil, size: size, mass: mass,
                  velocity: velocity, affectedByGravity: affectedByGravity, linearDamping: linearDamping,
                  isDynamic: isDynamic, allowsRotation: allowsRotation, restitution: restitution,
                  friction: friction, ownBitmask: ownBitmask, collideBitmask: collideBitmask,
                  contactBitmask: contactBitmask, zRotation: zRotation, impulse: impulse,
                  angularImpulse: angularImpulse)!
    }
}
