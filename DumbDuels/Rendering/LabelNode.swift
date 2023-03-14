//
//  LabelNode.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class LabelNode: Node {
    let labelNode: SKLabelNode

    public init(text: String?) {
        self.labelNode = SKLabelNode(text: text)
    }

    public var text: String? {
        get { labelNode.text }
        set { labelNode.text = newValue }
    }
}
