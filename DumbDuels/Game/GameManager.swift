//
//  GameManager.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 14/3/23.
//

import Foundation

protocol GameManager {
    let entityManager: EntityManager
    let eventManager: EventManager
    let systemManager: SystemManager
    func update(with time: Double)
}
