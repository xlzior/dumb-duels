//
//  Event.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

class Event: Comparable {
    var priority: Int

    init(priority: Int) {
        self.priority = priority
    }
}

extension Event {
    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.priority < rhs.priority
    }

    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.priority == rhs.priority
    }
}
