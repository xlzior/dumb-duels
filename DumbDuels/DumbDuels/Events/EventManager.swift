//
//  EventManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

private func sort(lhs: Event, rhs: Event) -> Bool {
    lhs.priority.rawValue < rhs.priority.rawValue
}

struct EventManager {
    private var systems: SystemManager
    private var events = PriorityQueue<Event>(sort: sort)

    init(systems: SystemManager) {
        self.systems = systems
    }

    mutating func fire(_ event: Event) {
        events.enqueue(event)
    }

    @discardableResult
    mutating func poll() -> Bool {
        guard let event = events.dequeue() else {
            return false
        }

        event.execute(with: systems)

        return true
    }

    @discardableResult
    mutating func pollAll() -> Bool {
        if events.isEmpty {
            return false
        }

        while !events.isEmpty {
            poll()
        }

        return true
    }
}
