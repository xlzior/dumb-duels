//
//  ComponentProviderTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

final class ComponentInstanceProviderTests: XCTestCase {
    func testProviderReturnsTheInstance() {
        let instance = XComponent(1)
        let provider1 = ComponentInstanceProvider(instance: instance)
        let providedComponent = provider1.getComponent() as? XComponent
        XCTAssertTrue(providedComponent === instance)
    }

    func testProvidersWithSameInstanceHaveSameIdentifier() {
        let instance = XComponent(1)
        let provider1 = ComponentInstanceProvider(instance: instance)
        let provider2 = ComponentInstanceProvider(instance: instance)
        XCTAssertEqual(provider1.identifier, provider2.identifier)
    }

    func testProvidersWithDifferentInstanceHaveDifferentIdentifier() {
        let provider1 = ComponentInstanceProvider(instance: XComponent(1))
        let provider2 = ComponentInstanceProvider(instance: XComponent(1))
        XCTAssertNotEqual(provider1.identifier, provider2.identifier)
    }
}
