//
//  EntityStateMachineTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DuelKit

final class EntityStateMachineTests: XCTestCase {
    var manager = EntityManager()
    var fsm = EntityStateMachine<String>(entity: .init(id: EntityID(), manager: .init()))
    var entity = Entity(id: EntityID(), manager: .init())

    override func setUp() {
        super.setUp()
        manager = EntityManager()
        entity = manager.createEntity()
        fsm = EntityStateMachine(entity: entity)
    }

    func testEnterStateAddsStatesComponents() {
        let state = EntityState()
        let component = XComponent()
        state.addMapping(forType: XComponent.self).withInstance(component)
        fsm.addState(name: "test", state: state)
        fsm.changeState(name: "test")
        let xComponent: XComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)!
        XCTAssertTrue(xComponent === component)
    }

    func testEnterSecondStateAddsSecondStatesComponents() {
        let state1 = EntityState()
        let component1 = XComponent()
        state1.addMapping(forType: XComponent.self).withInstance(component1)
        fsm.addState(name: "test1", state: state1)

        let state2 = EntityState()
        let component2 = YComponent()
        state2.addMapping(forType: YComponent.self).withInstance(component2)
        fsm.addState(name: "test2", state: state2)
        fsm.changeState(name: "test2")

        let yComponent: YComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)!
        XCTAssertTrue(yComponent === component2)
    }

    func testEnterSecondStateRemovesFirstStatesComponents() {
        let state1 = EntityState()
        let component1 = XComponent()
        state1.addMapping(forType: XComponent.self).withInstance(component1)
        fsm.addState(name: "test1", state: state1)
        fsm.changeState(name: "test1")

        let state2 = EntityState()
        let component2 = YComponent()
        state2.addMapping(forType: YComponent.self).withInstance(component2)
        fsm.addState(name: "test2", state: state2)
        fsm.changeState(name: "test2")

        XCTAssertFalse(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
    }

    func testEnterSecondStateDoesNotRemoveOverlappingComponents() {
        let state1 = EntityState()
        let component1 = XComponent()
        state1.addMapping(forType: XComponent.self).withInstance(component1)
        fsm.addState(name: "test1", state: state1)
        fsm.changeState(name: "test1")

        let state2 = EntityState()
        let component2 = YComponent()
        state2.addMapping(forType: XComponent.self).withInstance(component1)
        state2.addMapping(forType: YComponent.self).withInstance(component2)
        fsm.addState(name: "test2", state: state2)
        fsm.changeState(name: "test2")

        let xComponent: XComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)!
        XCTAssertTrue(xComponent === component1)
    }

    func testEnterSecondStateRemovesDifferentComponentsOfSameType() {
        let state1 = EntityState()
        let component1 = XComponent()
        state1.addMapping(forType: XComponent.self).withInstance(component1)
        fsm.addState(name: "test1", state: state1)
        fsm.changeState(name: "test1")

        let state2 = EntityState()
        let component3 = XComponent()
        let component2 = YComponent()
        state2.addMapping(forType: XComponent.self).withInstance(component3)
        state2.addMapping(forType: YComponent.self).withInstance(component2)
        fsm.addState(name: "test2", state: state2)
        fsm.changeState(name: "test2")

        let xComponent: XComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)!
        XCTAssertTrue(xComponent === component3)
    }

    func testCreateStateThenAddsState() {
        let state = fsm.createState(name: "test")
        let component = XComponent()
        state.addMapping(forType: XComponent.self).withInstance(component)
        fsm.changeState(name: "test")
        let xComponent: XComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)!
        XCTAssertTrue(xComponent === component)
    }

    func testCreateStateDoesNotChangeState() {
        let state = fsm.createState(name: "test")
        let component = XComponent()
        state.addMapping(forType: XComponent.self).withInstance(component)

        let xComponent: XComponent? = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertNil(xComponent)
    }

    func testCallChangeStateWithSameNameLeavesEntityComponentsIntact() {
        let state = fsm.createState(name: "test")
        let component1 = XComponent()
        let component2 = YComponent()
        state.addMapping(forType: XComponent.self).withInstance(component1)
        state.addMapping(forType: YComponent.self).withInstance(component2)
        let name = "test"
        fsm.changeState(name: name)
        var xComponent: XComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)!
        XCTAssertTrue(xComponent === component1)
        var yComponent: YComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)!
        XCTAssertTrue(yComponent === component2)
        fsm.changeState(name: name)
        xComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)!
        XCTAssertTrue(xComponent === component1)
        yComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)!
        XCTAssertTrue(yComponent === component2)
    }

    func testGetsDeinitedWhileBeingStronglyReferencedByComponentAssignedToEntity() {
        class Marker: Component {
            var id: ComponentID

            let fsm: EntityStateMachine<String>
            init(fsm: EntityStateMachine<String>) {
                self.fsm = fsm
                self.id = ComponentID()
            }
        }

        let manager = EntityManager()
        var entity = manager.createEntity()
        var markerComponent = Marker(fsm: EntityStateMachine<String>(entity: entity))
        entity.assign(component: markerComponent)
        weak var weakMarker = markerComponent
        weak var weakFsm = markerComponent.fsm
        manager.destroy(entity: entity)
        entity = manager.createEntity()
        markerComponent = .init(fsm: .init(entity: entity))
        XCTAssertNil(weakMarker)
        XCTAssertNil(weakFsm)
    }
}
