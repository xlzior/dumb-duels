//
//  Event.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

protocol Event {
    var priority: Int { get set }
    func execute()
}
