//
//  SystemManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 16/3/23.
//

class SystemManager {
    var systems = [System]()
    var nameToSystem = [String: System]()

    func register(_ system: any System) {
        systems.append(system)

        let name = String(describing: type(of: system).self)
        nameToSystem[name] = system
    }

    func get<S: System>(ofType type: S.Type) -> S? {
        let name = String(describing: type.self)
        return nameToSystem[name] as? S
    }

    func update() {
        for system in systems {
            system.update()
        }
    }
}
