//
//  EventManagerTests.swift
//  DumbDuelsTests
//
//  Created by Wen Jun Lye on 9/3/23.
//

import XCTest
@testable import DumbDuels

// TODO: rewrite eventmanager tests

// struct MockSystem {
//
// }
//
// struct MockEvent: Event {
//    var wasCalled = false
//    var priority: Int
//
//    init(priority: Int = 1) {
//        self.wasCalled = false
//        self.priority = priority
//    }
//
//    func execute() {
//
//    }
// }
//
// final class EventManagerTests: XCTestCase {
//    func testPoll_nothing() throws {
//        var manager = EventManager()
//        XCTAssertNil(manager.poll())
//    }
//
//    func testPoll_order() throws {
//        var manager = EventManager()
//        manager.fire(MockEvent(priority: 5))
//        manager.fire(MockEvent(priority: 1))
//        manager.fire(MockEvent(priority: 2))
//        manager.fire(MockEvent(priority: 4))
//        manager.fire(MockEvent(priority: 3))
//
//        manager.poll()
//    }
//
//    func testPoll_all() throws {
//        var manager = EventManager()
//    }
// }
