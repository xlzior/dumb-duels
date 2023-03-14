//
//  PhysicsBody.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class PhysicsBody {
    let body: SKPhysicsBody

    public init(rectangleOf size: CGSize, center: CGPoint) {
        body = SKPhysicsBody(rectangleOf: size, center: center)
    }

    public init(circleOf radius: CGFloat, center: CGPoint) {
        body = SKPhysicsBody(circleOfRadius: radius, center: center)
    }

    public var mass: CGFloat {
        get { body.mass }
        set { body.mass = newValue }
    }

    public var velocity: CGVector {
        get { body.velocity }
        set { body.velocity = newValue }
    }

    public var affectedByGravity: Bool {
        get { body.affectedByGravity }
        set { body.affectedByGravity = newValue }
    }

    public var linearDamping: CGFloat {
        get { body.linearDamping }
        set { body.linearDamping = newValue }
    }

    public var isDynamic: Bool {
        get { body.isDynamic }
        set { body.isDynamic = newValue }
    }

    public var allowsRotation: Bool {
        get { body.allowsRotation }
        set { body.allowsRotation = newValue }
    }

    public var restitution: CGFloat {
        get { body.restitution }
        set { body.restitution = newValue }
    }

    public var friction: CGFloat {
        get { body.friction }
        set { body.friction = newValue }
    }

    /// The category bit mask determines what physics bodies will come into contact or collide with this physics body.
    public var categoryBitMask: UInt32 {
        get { body.categoryBitMask }
        set { body.categoryBitMask = newValue }
    }

    /// The collision bit mask determines what physics bodies can collide with this physics body.
    /// If the logical AND of the collisionBitMask of this physics body with categoryBitMask of the other physics body produces a non-zero
    /// result, the 2 bodies can collide.
    public var collisionBitMask: UInt32 {
        get { body.collisionBitMask }
        set { body.collisionBitMask = newValue }
    }

    /// The contact test bit mask determines what physics bodies can come into contact with this physics body.
    /// If the logical AND of the contactTestBitMask of this physics body with categoryBitMask of the other physics body produces a non-zero
    /// result, the 2 bodies can come into contact.
    public var contactTestBitMask: UInt32 {
        get { body.contactTestBitMask }
        set { body.contactTestBitMask = newValue }
    }

    public func applyImpulse(_ impulse: CGVector) {
        body.applyImpulse(impulse)
    }
}
