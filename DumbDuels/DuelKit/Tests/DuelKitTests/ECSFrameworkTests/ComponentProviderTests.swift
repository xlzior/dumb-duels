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
