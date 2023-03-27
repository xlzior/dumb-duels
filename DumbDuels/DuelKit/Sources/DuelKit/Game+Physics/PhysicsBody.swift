//
//  PhysicsBody.swift
//  DuelKit
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class PhysicsBody: PhysicsSimulatableBody {
    private(set) var node: SKNode
    private let nodeNoPhysicsBodyFailureMessage = "SKNode does not contain an associated SKPhysicsBody."
    private let incorrectShapeInitializationFailureMessage =
        "Please pass in only either a size to initialize a rectangle body or a radius to initialize a circle body"

    init?(position: CGPoint = PhysicsEngineDefaults.position,
          size: CGSize? = nil,
          radius: CGFloat? = nil,
          zRotation: CGFloat = PhysicsEngineDefaults.zRotation,
          mass: CGFloat = PhysicsEngineDefaults.mass,
          velocity: CGVector = PhysicsEngineDefaults.velocity,
          affectedByGravity: Bool = PhysicsEngineDefaults.affectedByGravity,
          linearDamping: CGFloat = PhysicsEngineDefaults.linearDamping,
          isDynamic: Bool = PhysicsEngineDefaults.isDynamic,
          allowsRotation: Bool = PhysicsEngineDefaults.allowsRotation,
          restitution: CGFloat = PhysicsEngineDefaults.restitution,
          friction: CGFloat = PhysicsEngineDefaults.friction,
          categoryBitMask: UInt32 = PhysicsEngineDefaults.categoryBitMask,
          collisionBitMask: UInt32 = PhysicsEngineDefaults.collisionBitMask,
          contactBitMask: UInt32 = PhysicsEngineDefaults.contactBitMask
        ) {
        guard (size == nil && radius != nil) || (size != nil && radius == nil) else {
            assertionFailure(incorrectShapeInitializationFailureMessage)
            return nil
        }

        var body = SKPhysicsBody(circleOfRadius: 0)
        if let size = size {
            body = SKPhysicsBody(rectangleOf: size)
        } else if let radius = radius {
            body = SKPhysicsBody(circleOfRadius: radius)
        }

        self.node = SKNode()
        self.node.position = position
        self.node.zRotation = zRotation
        self.node.physicsBody = body
        self.mass = mass
        self.velocity = velocity
        self.affectedByGravity = affectedByGravity
        self.linearDamping = linearDamping
        self.isDynamic = isDynamic
        self.allowsRotation = allowsRotation
        self.restitution = restitution
        self.friction = friction
        self.categoryBitMask = categoryBitMask
        self.collisionBitMask = collisionBitMask
        self.contactTestBitMask = contactBitMask
    }

    func updateWith(newPhysicsBody: PhysicsBody) {
        guard node.physicsBody != nil else {
            assertionFailure(nodeNoPhysicsBodyFailureMessage)
            return
        }

        node.position = newPhysicsBody.position
        node.zRotation = newPhysicsBody.zRotation
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
        set {
            guard let physicsBody = node.physicsBody else {
                return
            }
            node.physicsBody = nil
            node.position = newValue
            node.physicsBody = physicsBody
        }
    }

    public var zRotation: CGFloat {
        get { node.zRotation }
        set { node.zRotation = newValue }
    }

    public var mass: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.mass
            }
            return physicsBody.mass
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.mass = newValue
        }
    }

    public var velocity: CGVector {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.velocity
            }
            return physicsBody.velocity
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.velocity = newValue
        }
    }

    public var affectedByGravity: Bool {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.affectedByGravity
            }
            return physicsBody.affectedByGravity
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.affectedByGravity = newValue
        }
    }

    public var linearDamping: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.linearDamping
            }
            return physicsBody.linearDamping
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.linearDamping = newValue
        }
    }

    public var isDynamic: Bool {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.isDynamic
            }
            return physicsBody.isDynamic
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.isDynamic = newValue
        }
    }

    public var allowsRotation: Bool {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.allowsRotation
            }
            return physicsBody.allowsRotation
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.allowsRotation = newValue
        }
    }

    public var restitution: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.restitution
            }
            return physicsBody.restitution
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.restitution = newValue
        }
    }

    public var friction: CGFloat {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.friction
            }
            return physicsBody.friction
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.friction = newValue
        }
    }

    /// The category bit mask determines what physics bodies will come into contact or collide with this physics body.
    public var categoryBitMask: UInt32 {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.categoryBitMask
            }
            return physicsBody.categoryBitMask
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.categoryBitMask = newValue
        }
    }

    /// The collision bit mask determines what physics bodies can collide with this physics body.
    /// If the logical AND of the collisionBitMask of this physics body with categoryBitMask of
    /// the other physics body produces a non-zero result, the 2 bodies can collide.
    public var collisionBitMask: UInt32 {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.collisionBitMask
            }
            return physicsBody.collisionBitMask
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.collisionBitMask = newValue
        }
    }

    /// The contact test bit mask determines what physics bodies can come into contact with this physics body.
    /// If the logical AND of the contactTestBitMask of this physics body with categoryBitMask of
    /// the other physics body produces a non-zero result, the 2 bodies can come into contact.
    public var contactTestBitMask: UInt32 {
        get {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return PhysicsEngineDefaults.contactBitMask
            }
            return physicsBody.contactTestBitMask
        }
        set {
            guard let physicsBody = node.physicsBody else {
                assertionFailure(nodeNoPhysicsBodyFailureMessage)
                return
            }
            physicsBody.contactTestBitMask = newValue
        }
    }

    public func applyImpulse(_ impulse: CGVector) {
        guard let physicsBody = node.physicsBody else {
            assertionFailure(nodeNoPhysicsBodyFailureMessage)
            return
        }
        physicsBody.applyImpulse(impulse)
    }

    public func applyAngularImpulse(_ impulse: CGFloat) {
        guard let physicsBody = node.physicsBody else {
            assertionFailure(nodeNoPhysicsBodyFailureMessage)
            return
        }
        physicsBody.applyAngularImpulse(impulse)
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
