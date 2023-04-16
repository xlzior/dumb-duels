//
//  FSMTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

final class StateComponentMappingTests: XCTestCase {
    func testAddReturnsDifferentMappingForSameComponentType() {
        let state = EntityState()
        let mapping = state.addMapping(forType: XComponent.self)
        XCTAssertFalse(mapping === mapping.add(componentType: XComponent.self))
    }

    func testAddReturnsDifferentMappingForDifferentComponentTypes() {
        let state = EntityState()
        let mapping = state.addMapping(forType: XComponent.self)
        XCTAssertFalse(mapping === mapping.add(componentType: YComponent.self))
    }

    func testAddAddsProviderToState() {
        let state = EntityState()
        let mapping = state.addMapping(forType: XComponent.self)
        mapping.add(componentType: YComponent.self)
        XCTAssertTrue(state.hasProvider(forType: XComponent.self))
    }
}
