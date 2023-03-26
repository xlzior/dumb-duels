//
//  Simulator.swift
//  DuelKit
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

/// The Simulator class
public class Simulator {
    let view: SKView
    public let gameScene: GameScene

    public init() {
        self.view = SKView()
        self.gameScene = GameScene()
    }

    // Need setup functions before start() is called
    // Takes in whatever the physics system passes to me
    // Entities and their physics information

    public func start() {
        view.presentScene(gameScene.baseGameScene)
    }

    public func stop() {
        view.presentScene(nil)
    }
}
