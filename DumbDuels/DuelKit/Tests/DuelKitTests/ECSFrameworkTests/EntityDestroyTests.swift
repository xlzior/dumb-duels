//
//  EntityDestroyTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 15/3/23.
//

import XCTest
@testable import DuelKit

final class EntityDestroyTests: XCTestCase {

    func testDestroyEntity() {
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)
        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        let xComponent = XComponent(1)
        let yComponent = YComponent(1)
        let entity1 = manager.createEntity {
            xComponent
        }
        let entity2 = manager.createEntity {
            yComponent
        }
        manager.destroy(entity: entity2)

        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 1)
        XCTAssertTrue(manager.exists(entity: entity1.id))
        XCTAssertFalse(manager.exists(entity: entity2.id))

        XCTAssertEqual(manager.members(withTraits: assemblage1.traits), Set([entity1.id]))
        XCTAssertEqual(manager.members(withTraits: assemblage2.traits), Set())
        XCTAssertEqual(manager.members(withTraits: assemblage3.traits), Set())
    }

    func testRemoveComponent() {
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
        manager.remove(componentType: YComponent.typeId, from: entity.id)

        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 1)
        XCTAssertTrue(manager.exists(entity: entity.id))
        XCTAssertEqual(manager.numAssemblages, 4)
        XCTAssertTrue(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
        XCTAssertFalse(manager.has(componentTypeId: YComponent.typeId, entityId: entity.id))

        XCTAssertEqual(manager.countComponents(for: entity.id), 1)
        XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set([XComponent.typeId]))

        // Ensure components retrieved is actually the components passed in
        var retrievedXComponent: XComponent? = manager.getComponent(for: entity.id)
        XCTAssertEqual(retrievedXComponent?.id, xComponent.id)
        retrievedXComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertEqual(retrievedXComponent?.id, xComponent.id)

        var retrievedYComponent: YComponent? = manager.getComponent(for: entity.id)
        XCTAssertNil(retrievedYComponent)
        retrievedYComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)
        XCTAssertNil(retrievedYComponent)

        // Ensure assemblage membership is correct
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
        XCTAssertTrue(manager.isMember(entity, ofAssemblageWithTraits: assemblage4.traits))
    }

    func testRemoveAllComponents() {
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
        manager.removeAllComponents(for: entity.id)

        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 0)
        XCTAssertTrue(manager.exists(entity: entity.id))
        XCTAssertEqual(manager.numAssemblages, 4)
        XCTAssertFalse(manager.has(componentTypeId: XComponent.typeId, entityId: entity.id))
        XCTAssertFalse(manager.has(componentTypeId: YComponent.typeId, entityId: entity.id))

        XCTAssertEqual(manager.countComponents(for: entity.id), 0)
        XCTAssertEqual(manager.getAllComponentTypes(for: entity.id), Set())

        // Ensure components retrieved is actually the components passed in
        var retrievedXComponent: XComponent? = manager.getComponent(for: entity.id)
        XCTAssertNil(retrievedXComponent)
        retrievedXComponent = manager.getComponent(ofType: XComponent.typeId, for: entity.id)
        XCTAssertNil(retrievedXComponent)

        var retrievedYComponent: YComponent? = manager.getComponent(for: entity.id)
        XCTAssertNil(retrievedYComponent)
        retrievedYComponent = manager.getComponent(ofType: YComponent.typeId, for: entity.id)
        XCTAssertNil(retrievedYComponent)

        // Ensure assemblage membership is correct
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage1.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage2.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage3.traits))
        XCTAssertFalse(manager.isMember(entity, ofAssemblageWithTraits: assemblage4.traits))
    }
}
