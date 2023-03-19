//
//  Event.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

protocol Event {
    var priority: EventPriority { get set }

    func execute(with systems: SystemManager)
}
