//
//  PhysicsBody.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class PhysicsBody {
    let node: SKNode
    private let assertionFailureMessage = "SKNode does not contain an associated SKPhysicsBody."

    public init(rectangleOf size: CGSize, center: CGPoint, physicsDetails: PhysicsDetails) {
        let body = SKPhysicsBody(rectangleOf: size, center: center)
        self.node = SKNode()
        self.node.physicsBody = body
        updateWith(physicsDetails: physicsDetails)
    }

    public init(circleOf radius: CGFloat, center: CGPoint, physicsDetails: PhysicsDetails) {
        let body = SKPhysicsBody(circleOfRadius: radius, center: center)
        self.node = SKNode()
        self.node.physicsBody = body
        updateWith(physicsDetails: physicsDetails)
    }

    func updateWith(physicsDetails: PhysicsDetails) {
        mass = physicsDetails.mass
        velocity = physicsDetails.velocity
        affectedByGravity = physicsDetails.affectedByGravity
        linearDamping = physicsDetails.linearDamping
        isDynamic = physicsDetails.isDynamic
        allowsRotation = physicsDetails.allowsRotation
        restitution = physicsDetails.restitution
        friction = physicsDetails.friction
        categoryBitMask = physicsDetails.categoryBitMask
        collisionBitMask = physicsDetails.collisionBitMask
        contactTestBitMask = physicsDetails.contactTestBitMask
    }

    func updateWith(newPhysicsBody: PhysicsBody) {
        position = newPhysicsBody.position
        mass = newPhysicsBody.mass
        velocity = newPhysicsBody.velocity
        affectedByGravity = newPhysicsBody.affectedByGravity
        linearDamping = newPhysicsBody.linearDamping
        isDynamic = newPhysicsBody.isDynamic
        allowsRotation = newPhysicsBody.allowsRotation
        restitution = newPhysicsBody.restitution
        friction = newPhysicsBody.friction
        categoryBitMask = newPhysicsBody.categoryBitMask
        collisionBitMask = newPhysicsBody.collisionBitMask
        contactTestBitMask = newPhysicsBody.contactTestBitMask
    }

    public var position: CGPoint {
        get { node.position }
        set { node.position = newValue }
    }

    public var mass: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0
            }
            return physicsBody.mass
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.mass = newValue
        }
    }

    public var velocity: CGVector {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return CGVector.zero
            }
            return physicsBody.velocity
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.velocity = newValue
        }
    }

    public var affectedByGravity: Bool {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return true
            }
            return physicsBody.affectedByGravity
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.affectedByGravity = newValue
        }
    }

    public var linearDamping: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0.1
            }
            return physicsBody.linearDamping
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.linearDamping = newValue
        }
    }

    public var isDynamic: Bool {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return true
            }
            return physicsBody.isDynamic
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.isDynamic = newValue
        }
    }

    public var allowsRotation: Bool {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return true
            }
            return physicsBody.allowsRotation
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.allowsRotation = newValue
        }
    }

    public var restitution: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0.2
            }
            return physicsBody.restitution
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.restitution = newValue
        }
    }

    public var friction: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0.2
            }
            return physicsBody.friction
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.friction = newValue
        }
    }

    /// The category bit mask determines what physics bodies will come into contact or collide with this physics body.
    public var categoryBitMask: UInt32 {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0xFFFFFFFF
            }
            return physicsBody.categoryBitMask
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.categoryBitMask = newValue
        }
    }

    /// The collision bit mask determines what physics bodies can collide with this physics body.
    /// If the logical AND of the collisionBitMask of this physics body with categoryBitMask of the other physics body produces a non-zero
    /// result, the 2 bodies can collide.
    public var collisionBitMask: UInt32 {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0xFFFFFFFF
            }
            return physicsBody.collisionBitMask
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.collisionBitMask = newValue
        }
    }

    /// The contact test bit mask determines what physics bodies can come into contact with this physics body.
    /// If the logical AND of the contactTestBitMask of this physics body with categoryBitMask of the other physics body produces a non-zero
    /// result, the 2 bodies can come into contact.
    public var contactTestBitMask: UInt32 {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return 0x00000000
            }
            return physicsBody.contactTestBitMask
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(assertionFailureMessage)
                return
            }
            physicsBody.contactTestBitMask = newValue
        }
    }

    public func applyImpulse(_ impulse: CGVector) {
        guard let physicsBody = node.physicsBody else {
            assertionFailure(assertionFailureMessage)
            return
        }
        physicsBody.applyImpulse(impulse)
    }
}

extension PhysicsBody: Hashable {
    public static func == (lhs: PhysicsBody, rhs: PhysicsBody) -> Bool {
        lhs.node == rhs.node
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(node)
    }
}
