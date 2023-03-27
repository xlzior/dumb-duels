//
//  Event.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 9/3/23.
//

public protocol Event {
    var priority: Int { get set }

    func execute(with systems: SystemManager)
}
