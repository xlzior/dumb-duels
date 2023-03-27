//
//  AxeParticleComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 27/3/23.
//

import DuelKit
import Foundation

class AxeParticleComponent: Component {
    var id: ComponentID
    var createdTime: Date
    var survivalTime: TimeInterval // in seconds

    var destroyTime: Date {
        createdTime.addingTimeInterval(survivalTime)
    }

    init(createdTime: Date, survivalTime: TimeInterval = 0.3) {
        self.id = ComponentID()
        self.createdTime = createdTime
        self.survivalTime = survivalTime
    }
}
