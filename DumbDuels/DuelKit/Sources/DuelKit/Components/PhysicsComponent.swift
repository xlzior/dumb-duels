//
//  PhysicsComponent.swift
//  DuelKit
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

public class PhysicsComponent: Component {
    public enum Shape {
        case circle
        case rectangle
    }

    public var id: ComponentID
    public var shape: Shape
    public var radius: CGFloat?
    public var size: CGSize?
    public var mass: CGFloat
    public var velocity: CGVector
    public var affectedByGravity: Bool
    public var linearDamping: CGFloat
    public var isDynamic: Bool
    public var allowsRotation: Bool
    public var restitution: CGFloat
    public var friction: CGFloat
    public var zRotation: CGFloat
    public var impulse: CGVector
    public var angularImpulse: CGFloat
    public var ownBitmask: UInt32
    public var collideBitmask: UInt32
    public var contactBitmask: UInt32
    public var toBeRemoved: Bool
    public var shouldDestroyEntityWhenRemove: Bool

    private init?(shape: Shape, radius: CGFloat? = nil, size: CGSize? = nil,
                  mass: CGFloat, velocity: CGVector, affectedByGravity: Bool,
                  linearDamping: CGFloat, isDynamic: Bool, allowsRotation: Bool,
                  restitution: CGFloat, friction: CGFloat, ownBitmask: UInt32,
                  collideBitmask: UInt32, contactBitmask: UInt32,
                  zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat,
                  toBeRemoved: Bool = false, shouldDestroyEntityWhenRemove: Bool = false) {
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
        self.shouldDestroyEntityWhenRemove = shouldDestroyEntityWhenRemove
    }

    public convenience init(circleOf radius: CGFloat, mass: CGFloat, velocity: CGVector,
                            affectedByGravity: Bool, linearDamping: CGFloat, isDynamic: Bool,
                            allowsRotation: Bool, restitution: CGFloat, friction: CGFloat,
                            ownBitmask: UInt32, collideBitmask: UInt32, contactBitmask: UInt32,
                            zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat) {
        self.init(shape: .circle, radius: radius, size: nil, mass: mass,
                  velocity: velocity, affectedByGravity: affectedByGravity, linearDamping: linearDamping,
                  isDynamic: isDynamic, allowsRotation: allowsRotation, restitution: restitution,
                  friction: friction, ownBitmask: ownBitmask, collideBitmask: collideBitmask,
                  contactBitmask: contactBitmask, zRotation: zRotation, impulse: impulse,
                  angularImpulse: angularImpulse)!
    }

    public convenience init(rectangleOf size: CGSize, mass: CGFloat, velocity: CGVector,
                            affectedByGravity: Bool, linearDamping: CGFloat, isDynamic: Bool,
                            allowsRotation: Bool, restitution: CGFloat, friction: CGFloat,
                            ownBitmask: UInt32, collideBitmask: UInt32, contactBitmask: UInt32,
                            zRotation: CGFloat, impulse: CGVector, angularImpulse: CGFloat) {
        self.init(shape: .rectangle, radius: nil, size: size, mass: mass,
                  velocity: velocity, affectedByGravity: affectedByGravity, linearDamping: linearDamping,
                  isDynamic: isDynamic, allowsRotation: allowsRotation, restitution: restitution,
                  friction: friction, ownBitmask: ownBitmask, collideBitmask: collideBitmask,
                  contactBitmask: contactBitmask, zRotation: zRotation, impulse: impulse,
                  angularImpulse: angularImpulse)!
    }
}
