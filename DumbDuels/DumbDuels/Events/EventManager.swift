//
//  EventManager.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

struct EventManager {
    private var events = PriorityQueue<Event>()
    private var consumers = [any EventConsumer]()

    mutating func register(consumer: any EventConsumer) {
        consumers.append(consumer)
    }

    mutating func fire(_ event: Event) {
        events.enqueue(event)
    }

    @discardableResult
    mutating func poll() -> Bool {
        guard let event = events.dequeue() else {
            return false
        }

        for consumer in consumers {
            let chain = consumer.consume(event: event)
            events.enqueue(chain)
        }

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
