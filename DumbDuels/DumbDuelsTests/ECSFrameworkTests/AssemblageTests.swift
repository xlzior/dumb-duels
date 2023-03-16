//
//  AssemblageTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 16/3/23.
//

import XCTest
@testable import DumbDuels

final class AssemblageTests: XCTestCase {

    func testConstruction() {
        let manager = EntityManager()
        let assemblage = manager.assemblage(requiredComponents: XComponent.self,
                                            excludedComponents: YComponent.self)
        XCTAssertTrue(assemblage.manager === manager)
        XCTAssertEqual(manager.numAssemblages, 1)
        XCTAssertEqual(manager.numEntities, 0)
        XCTAssertEqual(manager.numComponents, 0)

        let traits = TraitSet(requiredComponents: [XComponent.self],
                              excludedComponents: [YComponent.self])
        XCTAssertEqual(assemblage.traits, traits)
    }

    // It is fine to have multiple assemblages with same TraitSet
    func testAssemblageCollision() {
        let manager = EntityManager()
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self,
                                            excludedComponents: YComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: XComponent.self,
                                            excludedComponents: YComponent.self)
        XCTAssertEqual(manager.numAssemblages, 1)
        XCTAssertEqual(manager.numEntities, 0)
        XCTAssertEqual(manager.numComponents, 0)

        XCTAssertEqual(assemblage1, assemblage2)
    }

    func testAssemblageAutoUpdate_entityAddedAndDestroyedAfterAssemblageCreation() {
        let manager = EntityManager()
        let assemblage = manager.assemblage(requiredComponents: XComponent.self,
                                            excludedComponents: YComponent.self)
        let entity = manager.createEntity()
        manager.assign(component: XComponent(1), to: entity)
        XCTAssertEqual(assemblage.members, Set([entity.id]))
        XCTAssertEqual(assemblage.count, 1)
        manager.remove(componentType: XComponent.typeId, from: entity.id)
        XCTAssertEqual(assemblage.members, Set())
        XCTAssertEqual(assemblage.count, 0)
        let components: [Component] = [XComponent(1), YComponent(1)]
        manager.assign(components: components, to: entity.id)
        XCTAssertEqual(assemblage.members, Set())
        XCTAssertEqual(assemblage.count, 0)
        manager.remove(componentType: YComponent.typeId, from: entity.id)
        XCTAssertEqual(assemblage.members, Set([entity.id]))
        XCTAssertEqual(assemblage.count, 1)
        manager.destroy(entity: entity)
        XCTAssertEqual(manager.numAssemblages, 1)
        XCTAssertEqual(assemblage.members, Set())
        XCTAssertEqual(assemblage.count, 0)
    }

    func testAssemblageAutoUpdate_assemblageCreatedAfterEntityCreation() {
        let manager = EntityManager()
        let early = manager.createEntity(with: XComponent(1))
        let assemblage = manager.assemblage(requiredComponents: XComponent.self)
        XCTAssertEqual(manager.numAssemblages, 1)
        XCTAssertEqual(manager.numEntities, 1)
        XCTAssertEqual(manager.numComponents, 1)
        XCTAssertTrue(assemblage.isMember(entity: early))
        XCTAssertEqual(assemblage.count, 1)
        let late = manager.createEntity(with: XComponent(1))
        XCTAssertEqual(manager.numAssemblages, 1)
        XCTAssertEqual(manager.numEntities, 2)
        XCTAssertEqual(manager.numComponents, 2)
        XCTAssertTrue(assemblage.isMember(entity: late))
        XCTAssertEqual(assemblage.count, 2)
    }

    func testAssemblageExchange() {
        let numCopies = 10
        let manager = EntityManager()
        for idx in 0..<numCopies {
            manager.createEntity(with: XComponent(idx))
        }
        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self,
                                             excludedComponents: YComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self,
                                             excludedComponents: XComponent.self)
        XCTAssertEqual(manager.numAssemblages, 2)
        XCTAssertEqual(manager.numEntities, numCopies)
        XCTAssertEqual(manager.numComponents, numCopies)
        XCTAssertEqual(assemblage1.count, numCopies)
        XCTAssertEqual(assemblage2.count, 0)

        assemblage1.entities.forEach { entity in
            manager.assign(component: YComponent(1), to: entity)
            manager.remove(componentType: XComponent.typeId, from: entity.id)
        }

        XCTAssertEqual(manager.numAssemblages, 2)
        XCTAssertEqual(manager.numEntities, numCopies)
        XCTAssertEqual(manager.numComponents, numCopies)
        XCTAssertEqual(assemblage1.count, 0)
        XCTAssertEqual(assemblage2.count, numCopies)

        assemblage2.entities.forEach { entity in
            manager.assign(component: XComponent(1), to: entity)
            manager.remove(componentType: YComponent.typeId, from: entity.id)
        }

        XCTAssertEqual(manager.numAssemblages, 2)
        XCTAssertEqual(manager.numEntities, numCopies)
        XCTAssertEqual(manager.numComponents, numCopies)
        XCTAssertEqual(assemblage2.count, 0)
        XCTAssertEqual(assemblage1.count, numCopies)
    }

    func testComponentsAndMembersIteration() {
        let numCopies = 1_000
        let manager = EntityManager()
        for idx in 0..<numCopies {
            manager.createEntity(with: XComponent(idx), YComponent(idx))
        }
        for idx in 0..<numCopies {
            manager.createEntity(with: ZComponent(idx))
        }

        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self)
        let assemblage2 = manager.assemblage(requiredComponents: YComponent.self)

        // Components Iteration
        assemblage1.forEach { xComponent in
            XCTAssertNotNil(xComponent)
        }
        assemblage2.forEach { yComponent in
            XCTAssertNotNil(yComponent)
        }

        // Member id iteration
        var count = 0
        for entity in assemblage1.entities {
            XCTAssertNotNil(entity)
            count += 1
        }
        XCTAssertEqual(count, numCopies)
    }

    func testCreateMembers() {
        let manager = EntityManager()

        let assemblage1 = manager.assemblage(requiredComponents: XComponent.self,
                                             excludedComponents: YComponent.self)
        XCTAssertTrue(assemblage1.isEmpty)
        let entity1 = assemblage1.createMember(with: XComponent(1))
        XCTAssertEqual(assemblage1.count, 1)
        XCTAssertTrue(assemblage1.isMember(entity: entity1))
        XCTAssertEqual(manager.numComponents, 1)
        XCTAssertEqual(manager.numEntities, 1)

        let assemblage2 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self)
        XCTAssertTrue(assemblage2.isEmpty)
        let entity2 = assemblage2.createMember(with: (XComponent(1), YComponent(1)))
        XCTAssertEqual(assemblage2.count, 1)
        XCTAssertTrue(assemblage2.isMember(entity: entity2))
        XCTAssertEqual(manager.numComponents, 3)
        XCTAssertEqual(manager.numEntities, 2)

        let assemblage3 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self,
                                             ZComponent.self)
        XCTAssertTrue(assemblage3.isEmpty)
        let entity3 = assemblage3.createMember(with: (XComponent(1), YComponent(1), ZComponent(1)))
        XCTAssertEqual(assemblage3.count, 1)
        XCTAssertTrue(assemblage3.isMember(entity: entity3))
        XCTAssertEqual(manager.numComponents, 6)
        XCTAssertEqual(manager.numEntities, 3)

        let assemblage4 = manager.assemblage(requiredComponents: XComponent.self, YComponent.self,
                                             ZComponent.self, WComponent.self)
        XCTAssertTrue(assemblage4.isEmpty)
        let entity4 = assemblage4.createMember(with: (XComponent(1), YComponent(1), ZComponent(1),
                                                     WComponent(1)))
        XCTAssertEqual(assemblage4.count, 1)
        XCTAssertTrue(assemblage4.isMember(entity: entity4))
        XCTAssertEqual(manager.numComponents, 10)
        XCTAssertEqual(manager.numEntities, 4)
    }
}
