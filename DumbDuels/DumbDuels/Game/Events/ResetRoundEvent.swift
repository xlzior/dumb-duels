//
//  ResetRoundEvent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

struct ResetRoundEvent: Event {
    var priority: EventPriority = .game

    var entityId: EntityID

    func execute(with systems: SystemManager) {
        // for every player, changing their state to holding axe
        // this will restore the HoldingAxeComponent
        // restore axe positions to the starting position (based on the player position, and their facing)
        // reset ourselves, not via a moveevent
    }
}
