//
//  FSMTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

final class EntityStateTests: XCTestCase {
    private var state = EntityState()

    override func setUp() {
        super.setUp()
        state = EntityState()
    }

    override func tearDown() {
        super.tearDown()
        state = EntityState()
    }

    func testAddMappingWithNoQualifierCreatesTypeProvider() {
        state.addMapping(forType: XComponent.self)
        let provider = state.providers[XComponent.typeId]
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is ComponentTypeProvider?)
        XCTAssertTrue(provider?.getComponent() is XComponent?)
    }

    func testAddMappingWithTypeQualifierCreatesTypeProvider() {
        state.addMapping(forType: XComponent.self).withType(YComponent.self)
        let provider = state.providers[XComponent.typeId]
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is ComponentTypeProvider?)
        XCTAssertTrue(provider?.getComponent() is YComponent?)
    }

    func testAddMappingWithInstanceQualifierCreatesInstanceProvider() {
        let component = XComponent()
        state.addMapping(forType: XComponent.self).withInstance(component)
        let provider = state.providers[XComponent.typeId]
        XCTAssertTrue(provider is ComponentInstanceProvider?)
        XCTAssertTrue(provider?.getComponent() === component)
    }

    func testAddMappingWithMethodQualifierCreatesDynamicProvider() {
        let dynamickProvider = DynamicComponentProvider.Closure {
            XComponent()
        }

        state.addMapping(forType: XComponent.self).withMethod(dynamickProvider)
        let provider = state.providers[XComponent.typeId]
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is DynamicComponentProvider<XComponent>?)
        XCTAssertTrue(provider?.getComponent() is XComponent)
    }

    func testProviderForTypeReturnsTypeProviderByDefault() {
        state.addMapping(forType: XComponent.self)
        let provider = state.getProvider(forType: XComponent.self)
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is ComponentTypeProvider?)
    }

    func testProviderForTypeReturnsInstanceProvider() {
        let component = XComponent()
        state.addMapping(forType: XComponent.self).withInstance(component)
        let provider = state.getProvider(forType: XComponent.self)
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is ComponentInstanceProvider?)
    }

    func testProviderForTypeReturnsDynamicProvider() {
        state.addMapping(forType: XComponent.self).withMethod(.init { XComponent() })
        let provider = state.getProvider(forType: XComponent.self)
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is DynamicComponentProvider<XComponent>?)
    }

    func testProviderForTypeReturnsTypeProvider() {
        state.addMapping(forType: XComponent.self).withType(XComponent.self)
        let provider = state.getProvider(forType: XComponent.self)
        XCTAssertNotNil(provider)
        XCTAssertTrue(provider is ComponentTypeProvider?)
    }

    func testHasProviderReturnsFalseForNotCreatedProvider() {
        XCTAssertFalse(state.hasProvider(forType: XComponent.self))
    }

    func testHasProviderReturnsTrueForCreatedProvider() {
        state.addMapping(forType: XComponent.self)
        XCTAssertTrue(state.hasProvider(forType: XComponent.self))
    }

    func testAddInstanceCreatesMappingAndSetsInstanceProviderForInstanceType() {
        let component = XComponent()
        state.addInstance(component)
        XCTAssertTrue(state.getProvider(forType: XComponent.self) is ComponentInstanceProvider?)
        XCTAssert(state.getProvider(forType: XComponent.self)?.getComponent() === component)
    }

    func testAddTypeCreatesMappingAndSetsTypeProviderForType() {
        state.addType(XComponent.self)
        XCTAssertTrue(state.getProvider(forType: XComponent.self) is ComponentTypeProvider?)
        XCTAssertNotNil(state.getProvider(forType: XComponent.self)?.getComponent())
        XCTAssertTrue(state.getProvider(forType: XComponent.self)?.getComponent() is XComponent?)
    }

    func testAddMethodCreatesMappingAndSetsDynamicProviderForType() {
        let component = XComponent()
        state.addMethod(closure: .init { component })
        XCTAssertTrue(state.getProvider(forType: XComponent.self) is DynamicComponentProvider<XComponent>?)
        XCTAssertTrue(state.getProvider(forType: XComponent.self)?.getComponent() === component)
    }
}
