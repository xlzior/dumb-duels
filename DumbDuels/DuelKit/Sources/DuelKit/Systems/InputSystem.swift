//
//  InputSystem.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 24/3/23.
//

public protocol InputSystem: System {

    func handleButtonDown(playerIndex: Int)
    func handleButtonUp(playerIndex: Int)

    var playerIndexToIdMap: [Int: EntityID] { get set }
}
