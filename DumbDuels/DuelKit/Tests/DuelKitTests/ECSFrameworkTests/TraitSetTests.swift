//
//  TraitSetTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

final class TraitSetTests: XCTestCase {

    func testCommutativity() {
        let trait1 = TraitSet(requiredComponents: [XComponent.self, YComponent.self],
                              excludedComponents: [ZComponent.self])
        let trait2 = TraitSet(requiredComponents: [YComponent.self, XComponent.self],
                              excludedComponents: [ZComponent.self])
        let trait3 = TraitSet(requiredComponents: [YComponent.self, ZComponent.self],
                              excludedComponents: [XComponent.self])

        XCTAssertEqual(trait1, trait2)
        XCTAssertEqual(trait1.hashValue, trait2.hashValue)
        XCTAssertNotEqual(trait1, trait3)
        XCTAssertNotEqual(trait1.hashValue, trait3.hashValue)
    }

    func testIsMatch() {
        let manager = EntityManager()
        let entity = manager.createEntity {
            XComponent(1)
            YComponent(2)
            ZComponent(3)
            WComponent(4)
        }

        let noMatch = manager.assemblage(requiredComponents: XComponent.self, YComponent.self,
                                         excludedComponents: ZComponent.self)
        let isMatch = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)

        XCTAssertTrue(isMatch.canBecomeMember(entity: entity))
        XCTAssertFalse(noMatch.canBecomeMember(entity: entity))
    }

}
