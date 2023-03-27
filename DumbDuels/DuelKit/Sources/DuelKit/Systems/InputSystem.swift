//
//  InputSystem.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 24/3/23.
//

public protocol InputSystem: System {
    func handleButtonDown(entityId: EntityID)
    func handleButtonUp(entityId: EntityID)
}
