//
//  Simulatable.swift
//  
//
//  Created by Bryan Kwok on 27/3/23.
//

import Foundation

public protocol Simulatable {
    var gameScene: GameScene { get set }
    func start()
    func stop()
}
