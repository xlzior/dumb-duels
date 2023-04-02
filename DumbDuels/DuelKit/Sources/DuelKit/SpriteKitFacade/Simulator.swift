//
//  Simulator.swift
//  DuelKit
//
//  Created by Bryan Kwok on 15/3/23.
//

import SpriteKit

public class Simulator: Simulatable {
    let view: SKView
    public var gameScene: Scene

    public init() {
        self.view = SKView()
        self.gameScene = GameScene()
    }

    // Need setup functions before start() is called
    // Takes in whatever the physics system passes to me
    // Entities and their physics information

    public func start() {
        guard let gameScene = self.gameScene as? GameScene else {
            assertionFailure("Internal representation of Scene should use GameScene")
            return
        }
        view.presentScene(gameScene.baseGameScene)
    }

    public func stop() {
        view.presentScene(nil)
    }
}
