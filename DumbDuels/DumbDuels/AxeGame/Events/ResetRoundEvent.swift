//
//  ResetRoundEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 15/4/23.
//

import DuelKit

struct ResetRoundEvent: Event {
    var priority: Int = 2

    func execute(with systems: SystemManager) {
        guard let roundSystem: AXRoundSystem = systems.get(ofType: AXRoundSystem.self),
              let inputSystem: AXInputSystem = systems.get(ofType: AXInputSystem.self) else {
            return
        }

        roundSystem.reset()
        inputSystem.reset()
    }
}
