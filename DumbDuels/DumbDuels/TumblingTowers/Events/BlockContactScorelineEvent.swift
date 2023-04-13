//
//  BlockContactScorelineEvent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

struct BlockContactScorelineEvent: Event {
    var priority = 2 // TODO: check this priority

    var blockId: EntityID
    var scoreLineId: EntityID

    func execute(with systems: SystemManager) {
        guard let scoreSystem = systems.get(ofType: TTScoreSystem.self) else {
            return
        }

        scoreSystem.handleBlockContactScoreline(landedBlockId: blockId, scorelineId: scoreLineId)
    }
}
