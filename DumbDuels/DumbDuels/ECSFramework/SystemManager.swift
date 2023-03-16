//
//  SystemManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class SystemManager {
    // TODO: hashmap from System.Type to System
    var systems: [any System] = []

    func register(_ system: any System) {
        systems.append(system)
    }

    func get<C: System>() -> C? {
        systems.compactMap({ _ in systems as? C }).first
    }
}
