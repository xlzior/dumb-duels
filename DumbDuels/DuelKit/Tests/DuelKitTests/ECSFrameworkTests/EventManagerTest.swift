//
//  EventManager.swift
//  
//
//  Created by Wen Jun Lye on 16/4/23.
//

import XCTest
@testable import DuelKit

struct DoNothingEvent: Event {
    var priority: Int

    init(priority: Int) {
        self.priority = priority
    }

    func execute(with systems: SystemManager) {

    }
}

class XSystem: System {
    unowned let entityManager: EntityManager
    let assemblage: Assemblage1<XComponent>

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        self.assemblage = entityManager.assemblage(requiredComponents: XComponent.self)

        for _ in 1...10 {
            assemblage.createMember(with: XComponent(0))
        }
    }

    func update() {

    }

    func doSomething() {
        for xComponent in assemblage {
            xComponent.x += 1
        }
    }
}

struct CallSystemEvent: Event {
    var priority: Int

    init(priority: Int) {
        self.priority = priority
    }

    func execute(with systems: SystemManager) {
        guard let xSystem: XSystem = systems.get(ofType: XSystem.self) else {
            XCTFail("XSystem not found")
            return
        }

        xSystem.doSomething()
    }
}

final class EventManagerTest: XCTestCase {
    func testPerformanceFire() throws {
        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)

        self.measure {
            for _ in 1...10_000 {
                let event = DoNothingEvent(priority: Int.random(in: 1...10))
                eventManager.fire(event)
            }
        }
    }

    func testPerformanceDequeue() throws {
        let systemManager = SystemManager()
        let eventManager = EventManager(systems: systemManager)

        self.measure {
            for _ in 1...2_500 {
                let event = DoNothingEvent(priority: Int.random(in: 1...10))
                eventManager.fire(event)
            }

            eventManager.pollAll()
        }
    }

    func testPerformanceDoSomething() throws {
        let entityManager = EntityManager()
        let systemManager = SystemManager()
        let xSystem = XSystem(entityManager: entityManager)
        systemManager.register(xSystem)
        let eventManager = EventManager(systems: systemManager)

        self.measure {
            for _ in 1...1_000 {
                let event = CallSystemEvent(priority: Int.random(in: 1...10))
                eventManager.fire(event)
            }
            eventManager.pollAll()
        }

        for xComponent in xSystem.assemblage {
            XCTAssertEqual(xComponent.x, 10_000)
        }
    }
}
