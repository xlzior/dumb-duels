//
//  SpriteNode.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 13/3/23.
//

import SpriteKit

public class SpriteNode: Node {
    let spriteNode: SKSpriteNode

    public init(imageNamed: String) {
        self.spriteNode = SKSpriteNode(imageNamed: imageNamed)
    }

    
}
