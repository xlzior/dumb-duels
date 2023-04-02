//
//  ComponentTests.swift
//  DumbDuelsTests
//
//  Created by Bing Sen Lim on 15/3/23.
//

@testable import DuelKit
import XCTest

final class ComponentTests: XCTestCase {
    func testStaticTypeId() {
        XCTAssertEqual(XComponent.typeId, XComponent.typeId)
        XCTAssertEqual(YComponent.typeId, YComponent.typeId)
        XCTAssertEqual(ZComponent.typeId, ZComponent.typeId)

        XCTAssertNotEqual(XComponent.typeId, YComponent.typeId)
        XCTAssertNotEqual(XComponent.typeId, ZComponent.typeId)
        XCTAssertNotEqual(YComponent.typeId, ZComponent.typeId)
    }

    func testInstanceTypeId() {
        let x1 = XComponent(1)
        let x2 = XComponent(2)
        let y1 = YComponent(1)

        XCTAssertEqual(x1.typeId, XComponent.typeId)
        XCTAssertEqual(x2.typeId, XComponent.typeId)
        XCTAssertEqual(x1.typeId, XComponent.typeId)
        XCTAssertEqual(y1.typeId, YComponent.typeId)
        XCTAssertNotEqual(y1.typeId, XComponent.typeId)
    }

    func testInstanceId() {
        let x1 = XComponent(1)
        let x2 = XComponent(2)
        let y1 = YComponent(1)

        XCTAssertNotEqual(x1.id, x2.id)
        XCTAssertNotEqual(x1.id, y1.id)
        XCTAssertNotEqual(x2.id, y1.id)
    }
}
