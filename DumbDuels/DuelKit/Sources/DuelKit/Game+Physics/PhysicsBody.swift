//
//  PhysicsBody.swift
//  DuelKit
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

class PhysicsBody: PhysicsSimulatableBody {
    private(set) var node: SKNode
    private let nodeNoPhysicsBodyFailureMessage = "SKNode does not contain an associated SKPhysicsBody."
    private let incorrectShapeInitializationFailureMessage =
        "Please pass in only either a size to initialize a rectangle body or a radius to initialize a circle body"

    init(circleOf radius: CGFloat, at position: CGPoint) {
        let body = SKPhysicsBody(circleOfRadius: radius)
        self.node = SKNode()
        self.node.position = position
        self.node.physicsBody = body
    }

    init(rectangleOf size: CGSize, at position: CGPoint) {
        let body = SKPhysicsBody(rectangleOf: size)
        self.node = SKNode()
        self.node.position = position
        self.node.physicsBody = body
    }

    var position: CGPoint {
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

    var zRotation: CGFloat {
        get { node.zRotation }
        set { node.zRotation = newValue }
    }

    var mass: CGFloat {
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

    var velocity: CGVector {
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

    var affectedByGravity: Bool {
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

    var linearDamping: CGFloat {
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

    var isDynamic: Bool {
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

    var allowsRotation: Bool {
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

    var restitution: CGFloat {
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

    var friction: CGFloat {
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
    var categoryBitMask: UInt32 {
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
    var collisionBitMask: UInt32 {
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
    var contactTestBitMask: UInt32 {
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

    func applyImpulse(_ impulse: CGVector) {
        guard let physicsBody = node.physicsBody else {
            assertionFailure(nodeNoPhysicsBodyFailureMessage)
            return
        }
        physicsBody.applyImpulse(impulse)
    }

    func applyAngularImpulse(_ impulse: CGFloat) {
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
