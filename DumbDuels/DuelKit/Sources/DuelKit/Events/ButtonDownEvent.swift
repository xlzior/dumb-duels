//
//  ButtonDownEvent.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct ButtonDownEvent: Event {
    var priority = 1

    var index: Int

    func execute(with systems: SystemManager) {
        systems.inputSystem?.handleButtonDown(playerIndex: index)
    }
}
