//
//  ComponentProviderTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

class ComponentTypeProviderTests: XCTestCase {
    func testProviderReturnsAnInstanceOfType() {
        let provider = ComponentTypeProvider(componentType: XComponent.self)
        let component = provider.getComponent() as? XComponent
        XCTAssertNotNil(component)
    }

    func testProviderReturnsNewInstanceEachTime() {
        let provider = ComponentTypeProvider(componentType: XComponent.self)
        let component1 = provider.getComponent() as? XComponent
        let component2 = provider.getComponent() as? XComponent
        XCTAssertFalse(component1 === component2)
    }

    func testProvidersWithSameTypeHaveSameIdentifier() {
        let provider1 = ComponentTypeProvider(componentType: XComponent.self)
        let provider2 = ComponentTypeProvider(componentType: XComponent.self)
        XCTAssertEqual(provider1.identifier, provider2.identifier)
    }

    func testProvidersWithDifferentTypeHaveDifferentIdentifier() {
        let provider1 = ComponentTypeProvider(componentType: XComponent.self)
        let provider2 = ComponentTypeProvider(componentType: YComponent.self)
        XCTAssertNotEqual(provider1.identifier, provider2.identifier)
    }
}
