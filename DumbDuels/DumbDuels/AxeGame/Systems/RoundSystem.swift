//
//  RoundSystem.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

import CoreGraphics

class RoundSystem: System {
    unowned var entityManager: EntityManager
    unowned var eventFirer: EventFirer

    private var axes: Assemblage2<AxeComponent, PositionComponent>
    private var players: Assemblage2<PlayerComponent, ScoreComponent>

    init(for entityManager: EntityManager, eventFirer: EventFirer) {
        self.entityManager = entityManager
        self.eventFirer = eventFirer
        self.axes = entityManager.assemblage(requiredComponents: AxeComponent.self, PositionComponent.self)
        self.players = entityManager.assemblage(requiredComponents: PlayerComponent.self, ScoreComponent.self)
    }

    func update() {
        let frame = CGRect(origin: CGPoint.zero, size: Sizes.game)
        for (_, position) in axes where frame.contains(position.position) {
            return
        }
        checkWin()
        reset()
    }

    func checkWin() {
        for (entity, _, score) in players.entityAndComponents where score.score >= 5 {
            eventFirer.fire(GameWonEvent(entityId: entity.id))
        }
    }

    func reset() {
        for (player, _) in players {
            player.fsm.changeState(name: .holdingAxe)
            // TODO: restore axe positions to the starting position?
        }
    }
}
