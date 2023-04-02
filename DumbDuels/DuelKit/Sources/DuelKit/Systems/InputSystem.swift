//
//  InputSystem.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 24/3/23.
//

public protocol InputSystem: System, IndexMapInitializable {

    func handleButtonDown(playerIndex: Int)
    func handleButtonUp(playerIndex: Int)
}
