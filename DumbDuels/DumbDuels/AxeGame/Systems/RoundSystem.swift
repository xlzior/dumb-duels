//
//  RoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class RoundSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    private var axes: Assemblage2<AxeComponent, PositionComponent>
    private var players: Assemblage1<PlayerComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.axes = entityManager.assemblage(requiredComponents: AxeComponent.self, PositionComponent.self)
        self.players = entityManager.assemblage(requiredComponents: PlayerComponent.self)
    }

    func update() {
        for (_, position) in axes {
            // TODO: if the axe is within the screen, return
        }
        // TODO: if we reach here, all axes are off screen
        // TODO: check whether game is won
        // TODO: fire a gamewon event?????
        reset()
    }

    func reset() {
        for (player) in players {
            player.fsm.changeState(name: .holdingAxe)
            // TODO: restore axe positions to the starting position?
        }
    }
}
