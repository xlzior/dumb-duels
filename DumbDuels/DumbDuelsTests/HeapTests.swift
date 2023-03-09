//
//  HeapTests.swift
//  DumbDuelsTests
//
//  Created by Wen Jun Lye on 8/3/23.
//

import XCTest
@testable import DumbDuels

final class HeapTests: XCTestCase {
    func testConstructEmpty() throws {
        let emptyHeap = Heap<Int>()
        XCTAssertTrue(emptyHeap.isEmpty)
        XCTAssertEqual(emptyHeap.count, 0)
        XCTAssertNil(emptyHeap.first)

        let emptyStringHeap = Heap<String>()
        XCTAssertTrue(emptyStringHeap.isEmpty)
        XCTAssertEqual(emptyStringHeap.count, 0)
        XCTAssertNil(emptyStringHeap.first)
    }

    func testConstruct() throws {
        let values = [4, 6, 8, 1, 3, 9, 7, 2, 5]
        let intHeap = Heap(array: values)
        XCTAssertFalse(intHeap.isEmpty)
        XCTAssertEqual(intHeap.count, values.count)
        XCTAssertEqual(intHeap.first, values.min())

        let stringValues = ["abc", "def", "ghi", "jkl", "mno", "pqr", "stu", "vwx", "yz"]
        let stringHeap = Heap(array: stringValues)
        XCTAssertFalse(stringHeap.isEmpty)
        XCTAssertEqual(stringHeap.count, stringValues.count)
        XCTAssertEqual(stringHeap.first, stringValues.min())
    }

    func testInsertSingleValue() throws {
        let value = 10
        var intHeap = Heap(array: [4, 6, 8])
        intHeap.insert(value)
        XCTAssertFalse(intHeap.isEmpty)
        XCTAssertEqual(intHeap.count, 4)
        XCTAssertEqual(intHeap.first, 4)

        let stringValue = "new"
        var stringHeap = Heap(array: ["abc", "def", "ghi"])
        stringHeap.insert(stringValue)
        XCTAssertFalse(stringHeap.isEmpty)
        XCTAssertEqual(stringHeap.count, 4)
        XCTAssertEqual(stringHeap.first, "abc")
    }

    func testInsertSequenceOfValues() throws {
        let values = [11, 12, 13]
        var intHeap = Heap(array: [4, 6, 8])
        intHeap.insert(values)
        XCTAssertFalse(intHeap.isEmpty)
        XCTAssertEqual(intHeap.count, 6)
        XCTAssertEqual(intHeap.first, 4)

        let stringValues = ["one", "two", "three"]
        var stringHeap = Heap(array: ["four", "five", "six"])
        stringHeap.insert(stringValues)
        XCTAssertFalse(stringHeap.isEmpty)
        XCTAssertEqual(stringHeap.count, 6)
        XCTAssertEqual(stringHeap.first, "five")
    }

    func testRemoveFirstValue() throws {
        var intHeap = Heap(array: [4, 6, 8, 1, 3, 9, 7, 2, 5])
        let first = intHeap.remove()
        XCTAssertEqual(first, 1)
        XCTAssertFalse(intHeap.isEmpty)
        XCTAssertEqual(intHeap.count, 8)
        XCTAssertEqual(intHeap.first, 2)

        var stringHeap = Heap(array: ["abc", "def", "ghi", "jkl", "mno", "pqr", "stu", "vwx", "yz"])
        let stringFirst = stringHeap.remove()
        XCTAssertEqual(stringFirst, "abc")
        XCTAssertFalse(stringHeap.isEmpty)
        XCTAssertEqual(stringHeap.count, 8)
        XCTAssertEqual(stringHeap.first, "def")
    }

    func testRemoveAllValues() throws {
        var intHeap = Heap(array: [4, 6, 8, 1, 3, 9, 7, 2, 5])
        while intHeap.remove() != nil {}
        XCTAssertTrue(intHeap.isEmpty)
        XCTAssertEqual(intHeap.count, 0)
        XCTAssertNil(intHeap.first)

        var stringHeap = Heap(array: ["abc", "def", "ghi", "jkl", "mno", "pqr",
                                      "stu", "vwx", "yz"])
        while stringHeap.remove() != nil {}
        XCTAssertTrue(stringHeap.isEmpty)
        XCTAssertEqual(stringHeap.count, 0)
        XCTAssertNil(stringHeap.first)
    }
}
