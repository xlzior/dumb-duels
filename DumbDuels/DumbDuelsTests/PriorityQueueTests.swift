//
//  PriorityQueueTests.swift
//  DumbDuelsTests
//
//  Created by Wen Jun Lye on 9/3/23.
//

import XCTest
@testable import DumbDuels

final class PriorityQueueTests: XCTestCase {
    func testEnqueue() {
        var intPQ = PriorityQueue<Int>(sort: <)
        intPQ.enqueue(5)
        XCTAssertFalse(intPQ.isEmpty)
        XCTAssertEqual(intPQ.count, 1)
        XCTAssertEqual(intPQ.first, 5)
        intPQ.enqueue(7)
        XCTAssertEqual(intPQ.count, 2)
        XCTAssertEqual(intPQ.first, 5)
        intPQ.enqueue(3)
        XCTAssertEqual(intPQ.count, 3)
        XCTAssertEqual(intPQ.first, 3)

        var stringPQ = PriorityQueue<String>(sort: <)
        stringPQ.enqueue("abc")
        XCTAssertFalse(stringPQ.isEmpty)
        XCTAssertEqual(stringPQ.count, 1)
        XCTAssertEqual(stringPQ.first, "abc")
        stringPQ.enqueue("def")
        XCTAssertEqual(stringPQ.count, 2)
        XCTAssertEqual(stringPQ.first, "abc")
        stringPQ.enqueue("ghi")
        XCTAssertEqual(stringPQ.count, 3)
        XCTAssertEqual(stringPQ.first, "abc")
    }

    func testEnqueueMultiple() {
        var intPQ = PriorityQueue<Int>(sort: <)
        intPQ.enqueue(5)
        intPQ.enqueue([7, 3, 2, 1, 4])
        XCTAssertEqual(intPQ.count, 6)
        XCTAssertEqual(intPQ.first, 1)

        var stringPQ = PriorityQueue<String>(sort: <)
        stringPQ.enqueue("abc")
        stringPQ.enqueue(["def", "ghi", "jkl"])
        XCTAssertEqual(stringPQ.count, 4)
        XCTAssertEqual(stringPQ.first, "abc")
    }

    func testDequeue() {
        var intPQ = PriorityQueue<Int>(sort: <)
        intPQ.enqueue(5)
        intPQ.enqueue(7)
        intPQ.enqueue(3)
        let first = intPQ.dequeue()
        XCTAssertEqual(first, 3)
        XCTAssertFalse(intPQ.isEmpty)
        XCTAssertEqual(intPQ.count, 2)
        XCTAssertEqual(intPQ.first, 5)
        let second = intPQ.dequeue()
        XCTAssertEqual(second, 5)
        XCTAssertFalse(intPQ.isEmpty)
        XCTAssertEqual(intPQ.count, 1)
        XCTAssertEqual(intPQ.first, 7)
        let third = intPQ.dequeue()
        XCTAssertEqual(third, 7)
        XCTAssertTrue(intPQ.isEmpty)
        XCTAssertEqual(intPQ.count, 0)
        XCTAssertNil(intPQ.first)

        var stringPQ = PriorityQueue<String>(sort: <)
        stringPQ.enqueue("abc")
        stringPQ.enqueue("def")
        stringPQ.enqueue("ghi")
        let stringFirst = stringPQ.dequeue()
        XCTAssertEqual(stringFirst, "abc")
        XCTAssertFalse(stringPQ.isEmpty)
        XCTAssertEqual(stringPQ.count, 2)
        XCTAssertEqual(stringPQ.first, "def")
        let stringSecond = stringPQ.dequeue()
        XCTAssertEqual(stringSecond, "def")
        XCTAssertFalse(stringPQ.isEmpty)
        XCTAssertEqual(stringPQ.count, 1)
        XCTAssertEqual(stringPQ.first, "ghi")
        let stringThird = stringPQ.dequeue()
        XCTAssertEqual(stringThird, "ghi")
        XCTAssertTrue(stringPQ.isEmpty)
        XCTAssertEqual(stringPQ.count, 0)
        XCTAssertNil(stringPQ.first)
    }
}
