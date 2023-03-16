//
//  Nexus+EntityTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 15/3/23.
//

import XCTest
@testable import DumbDuels

final class EntityCreationTests: XCTestCase {
    // not tests: numComponents, hasComponents, countComponents, exists
    func testCreateEntityOneComponent() {
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        let component = XComponent(1)
        let entity = manager.createEntity {
            component
        }
        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 1)
        XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
        XCTAssertEqual(manager.countComponents(for: entity.id), 1)
        XCTAssertTrue(manager.exists(entity: entity.id))
        XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId]))
        var retrievedComponent: XComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedComponent?.id, component.id)
        retrievedComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedComponent?.id, component.id)
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
    }

    func testCreateEntityMultipleComponent() {
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        let assemblage4 = manager.assemblage(requiredComponents: XComponent.self, excludedComponents: YComponent.self)
        let xComponent = XComponent(1)
        let yComponent = YComponent(2)
        let entity = manager.createEntity {
            xComponent
            yComponent
        }

        // Ensure entity, components and families setup properly into manager
        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 2)
        XCTAssertTrue(manager.exists(entity: entity.id))
        XCTAssertFalse(manager.exists(entity: EntityID()))
        XCTAssertEqual(manager.numAssemblages, 4)
        XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
        XCTAssertTrue(manager.has(componentTypeId: YComponent.typeId, entityId: entity.id))
        XCTAssertFalse(manager.has(componentTypeId: ZComponent.typeId, entityId: entity.id))
        XCTAssertEqual(manager.countComponents(for: entity.id), 2)
        XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId, YComponent.typeId]))

        // Ensure components retrieved is actually the components passed in
        var retrievedXComponent: XComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedXComponent?.id, xComponent.id)
        retrievedXComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedXComponent?.id, xComponent.id)

        var retrievedYComponent: YComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedYComponent?.id, yComponent.id)
        retrievedYComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedYComponent?.id, yComponent.id)

        // Ensure assemblage membership is correct
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage4.traits))
    }

    // Same test scenraio as testCreateOneEntityOneComponent
    // Except that we manually assign the component
    func testAssignOneComponent() {
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        let component = XComponent(1)
        let entity = manager.createEntity()
        // entity.assign(component: component)
        manager.assign(component: component, to: entity)

        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 1)
        XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
        XCTAssertEqual(manager.countComponents(for: entity.id), 1)
        XCTAssertTrue(manager.exists(entity: entity.id))
        XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId]))
        var retrievedComponent: XComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedComponent?.id, component.id)
        retrievedComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedComponent?.id, component.id)
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
    }

    func testAssignMultipleComponents() {
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        let assemblage4 = manager.assemblage(requiredComponents: XComponent.self, excludedComponents: YComponent.self)
        let xComponent = XComponent(1)
        let yComponent = YComponent(2)
        let entity = manager.createEntity()
        let components: [Component] = [xComponent, yComponent]
        // entity.assign(component: xComponent)
        // entity.assign(component: yComponent)
        manager.assign(components: components, to: entity)

        // Ensure entity, components and families setup properly into manager
        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 2)
        XCTAssertTrue(manager.exists(entity: entity.id))
        XCTAssertFalse(manager.exists(entity: EntityID()))
        XCTAssertEqual(manager.numAssemblages, 4)
        XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
        XCTAssertTrue(manager.has(componentTypeId: YComponent.typeId, entityId: entity.id))
        XCTAssertFalse(manager.has(componentTypeId: ZComponent.typeId, entityId: entity.id))
        XCTAssertEqual(manager.countComponents(for: entity.id), 2)
        XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId, YComponent.typeId]))

        // Ensure components retrieved is actually the components passed in
        var retrievedXComponent: XComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedXComponent?.id, xComponent.id)
        retrievedXComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedXComponent?.id, xComponent.id)

        var retrievedYComponent: YComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedYComponent?.id, yComponent.id)
        retrievedYComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedYComponent?.id, yComponent.id)

        // Ensure assemblage membership is correct
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage4.traits))
    }

    func testCreateMultipleEntitiesOneComponent() {
        let numCopies = 1000
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)

        manager.createEntities(count: numCopies) { context in
            XComponent(context.index)
        }

        // Ensure entity, components and families setup properly into manager
        XCTAssertEqual(manager.numEntities, numCopies)
        XCTAssertEqual(manager.numComponents, numCopies)
        XCTAssertFalse(manager.exists(entity: EntityID()))
        XCTAssertEqual(manager.numAssemblages, 3)

        let entityIterator = manager.makeEntitiesIterator()
        while let entity = entityIterator.next() {
            XCTAssertTrue(manager.exists(entity: entity.id))
            XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
            XCTAssertFalse(manager.has(componentTypeId: YComponent.typeId, entityId: entity.id))
            XCTAssertEqual(manager.countComponents(for: entity.id), 1)
            XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId]))

            // Ensure assemblage membership is correct
            XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
            XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
            XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
        }
    }

    func testCreateMultipleEntitiesMultipleComponent() {
        let numCopies = 1000
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        let assemblage4 = manager.assemblage(requiredComponents: XComponent.self, excludedComponents: YComponent.self)

        manager.createEntities(count: numCopies) { context in
            XComponent(context.index)
            YComponent(context.index)
        }

        // Ensure entity, components and families setup properly into manager
        XCTAssertEqual(manager.numEntities, numCopies)
        XCTAssertEqual(manager.numComponents, 2 * numCopies)
        XCTAssertFalse(manager.exists(entity: EntityID()))
        XCTAssertEqual(manager.numAssemblages, 4)

        let entityIterator = manager.makeEntitiesIterator()
        while let entity = entityIterator.next() {
            XCTAssertTrue(manager.exists(entity: entity.id))
            XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
            XCTAssertTrue(manager.has(componentTypeId: YComponent.typeId, entityId: entity.id))
            XCTAssertFalse(manager.has(componentTypeId: ZComponent.typeId, entityId: entity.id))
            XCTAssertEqual(manager.countComponents(for: entity.id), 2)
            XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId, YComponent.typeId]))

            // Ensure that correct components assigned to each entity
            let retrievedXComponent: XComponent? = manager.getComponent(for: entity.id)
            let retrievedYComponent: YComponent? = manager.getComponent(for: entity.id)
            XCTAssertEqual(retrievedXComponent?.x, retrievedYComponent?.y)

            // Ensure assemblage membership is correct
            XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
            XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
            XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
            XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage4.traits))
        }
    }
}
