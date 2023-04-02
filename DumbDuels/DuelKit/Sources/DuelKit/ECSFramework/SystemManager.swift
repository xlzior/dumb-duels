//
//  SystemManager.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 16/3/23.
//

public class SystemManager {
    var systems = [System]()
    var nameToSystem = [String: System]()
    var inputSystem: (any InputSystem)?

    public func register(_ system: any System) {
        systems.append(system)

        let name = String(describing: type(of: system).self)
        nameToSystem[name] = system

        if system is InputSystem {
            inputSystem = system as? InputSystem
        }
    }

    public func get<S: System>(ofType type: S.Type) -> S? {
        let name = String(describing: type.self)
        return nameToSystem[name] as? S
    }

    public func update() {
        for system in systems {
            system.update()
        }
    }

    public func updateIndexToIdMapping(firstId: EntityID, secondId: EntityID) {
        // TODO: remove this line and regression test, should not be necessary
        inputSystem?.setPlayerId(firstPlayer: firstId, secondPlayer: secondId)
        for system in systems {
            guard let initializableSystem = system as? IndexMapInitializable else {
                continue
            }
            initializableSystem.setPlayerId(firstPlayer: firstId, secondPlayer: secondId)
        }
    }
}
