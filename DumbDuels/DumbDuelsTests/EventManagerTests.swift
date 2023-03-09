//
//  EventManagerTests.swift
//  DumbDuelsTests
//
//  Created by Wen Jun Lye on 9/3/23.
//

import XCTest
@testable import DumbDuels

class MockEventConsumerWithChain: EventConsumer {
    var wasCalledWith = [Event]()

    func consume(event: Event) -> [Event] {
        wasCalledWith.append(event)
        return [Event(priority: event.priority + 1)]
    }
}

class MockEventConsumerWithoutChain: EventConsumer {
    var wasCalledWith = [Event]()

    func consume(event: Event) -> [Event] {
        wasCalledWith.append(event)
        return []
    }
}

final class EventManagerTests: XCTestCase {
    func testPoll() {
        var manager = EventManager()
        let consumer = MockEventConsumerWithChain()
        manager.register(consumer: consumer)

        manager.fire(Event(priority: 1))
        XCTAssertTrue(manager.poll())
        XCTAssertEqual(consumer.wasCalledWith[0], Event(priority: 1))

        XCTAssertTrue(manager.poll())
        XCTAssertEqual(consumer.wasCalledWith[1], Event(priority: 2))
    }

    func testPollAll() {
        var manager = EventManager()
        let consumer = MockEventConsumerWithoutChain()
        manager.register(consumer: consumer)

        manager.fire(Event(priority: 3))
        manager.fire(Event(priority: 1))
        manager.fire(Event(priority: 2))

        XCTAssertTrue(manager.pollAll())
        XCTAssertEqual(consumer.wasCalledWith, [Event(priority: 1), Event(priority: 2), Event(priority: 3)])
    }
}
