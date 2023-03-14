//
//  Node.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class Node {
    let node: SKNode
    public var physicsBody: PhysicsBody? {
        didSet(newPhysicsBody) { node.physicsBody = newPhysicsBody?.body }
    }

    public init() {
        node = SKNode()
    }

    public var name: String? {
        get { node.name }
        set { node.name = newValue }
    }

    public var position: CGPoint {
        get { node.position }
        set { node.position = newValue }
    }

    public var xScale: CGFloat {
        get { node.xScale }
        set { node.xScale = newValue }
    }

    public var yScale: CGFloat {
        get { node.yScale }
        set { node.yScale = newValue }
    }

    public var zPosition: CGFloat {
        get { node.zPosition }
        set { node.zPosition = newValue }
    }

    public var zRotation: CGFloat {
        get { node.zRotation }
        set { node.zRotation = newValue }
    }
}

extension Node: Hashable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.node == rhs.node
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(node)
    }
}
