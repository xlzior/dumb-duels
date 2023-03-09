//
//  PriorityQueue.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 8/3/23.
//

struct PriorityQueue<T: Comparable> {
    fileprivate var heap = Heap<T>()

    public var isEmpty: Bool {
        heap.isEmpty
    }

    public var count: Int {
        heap.count
    }

    public var first: T? {
        heap.first
    }

    public mutating func enqueue(_ element: T) {
        heap.insert(element)
    }

    public mutating func enqueue<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        heap.insert(sequence)
    }

    public mutating func dequeue() -> T? {
        return heap.remove()
    }
}
