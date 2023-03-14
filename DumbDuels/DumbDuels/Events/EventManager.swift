//
//  EventManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

private func sort(lhs: Event, rhs: Event) -> Bool {
    lhs.priority < rhs.priority
}

struct EventManager {
    // TODO: needs to have a reference to the systems manager
    private var events = PriorityQueue<Event>(sort: sort)

    mutating func fire(_ event: Event) {
        events.enqueue(event)
    }

    @discardableResult
    mutating func poll() -> Bool {
        guard let event = events.dequeue() else {
            return false
        }

        // TODO: pass in systems manager to event, so event can effect changes
        event.execute()

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
