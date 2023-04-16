//
//  ComponentProviderTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

class DynamicComponentProviderTests: XCTestCase {
    func testProviderReturnsTheInstance() {
        let instance = XComponent(1)
        let providerMethod = DynamicComponentProvider.Closure { instance }
        let provider = DynamicComponentProvider(closure: providerMethod)
        let component = provider.getComponent() as? XComponent
        XCTAssertTrue(component === instance)
    }

    func testProvidersWithSameMethodHaveSameIdentifier() {
        let instance = XComponent(0)
        let providerMethod = DynamicComponentProvider.Closure { instance }
        let provider1 = DynamicComponentProvider(closure: providerMethod)
        let provider2 = DynamicComponentProvider(closure: providerMethod)
        XCTAssertEqual(provider1.identifier, provider2.identifier)
    }

    func testProvidersWithDifferentMethodsHaveDifferentIdentifier() {
        let instance = XComponent(1)
        let providerMethod1 = DynamicComponentProvider.Closure { instance }
        let providerMethod2 = DynamicComponentProvider.Closure { instance }
        let provider1 = DynamicComponentProvider(closure: providerMethod1)
        let provider2 = DynamicComponentProvider(closure: providerMethod2)
        XCTAssertNotEqual(provider1.identifier, provider2.identifier)
    }
}
