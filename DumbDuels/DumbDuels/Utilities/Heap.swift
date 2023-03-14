//
//  Heap.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 8/3/23.
//

struct Heap<T> {
    var nodes = [T]()
    private let sort: (T, T) -> Bool

    public init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }

    public init(sort: @escaping (T, T) -> Bool, array: [T]) {
        self.sort = sort
        self.nodes = array
        heapify()
    }

    private mutating func heapify() {
        for index in stride(from: nodes.count / 2 - 1, through: 0, by: -1) {
            bubbleDown(index)
        }
    }

    public var isEmpty: Bool {
        nodes.isEmpty
    }

    public var count: Int {
        nodes.count
    }

    public var first: T? {
        nodes.first
    }

    private func parent(of index: Int) -> Int {
        (index - 1) / 2
    }

    private func leftChild(of index: Int) -> Int {
        2 * index + 1
    }

    private func rightChild(of index: Int) -> Int {
        2 * index + 2
    }

    public mutating func insert(_ value: T) {
        nodes.append(value)
        bubbleUp(nodes.count - 1)
    }

    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            insert(value)
        }
    }

    @discardableResult public mutating func remove() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }

        if nodes.count == 1 {
            return nodes.removeLast()
        }

        let value = nodes[0]
        nodes[0] = nodes.removeLast()
        bubbleDown(0)
        return value
    }

    private mutating func bubbleUp(_ index: Int) {
        let node = nodes[index]
        var childIndex = index
        var parentIndex = parent(of: childIndex)

        while childIndex > 0 && sort(node, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = parent(of: childIndex)
        }

        nodes[childIndex] = node
    }

    private mutating func bubbleDown(start: Int, end: Int) {
        let left = leftChild(of: start)
        let right = rightChild(of: start)

        var first = start
        if left < end && sort(nodes[left], nodes[first]) {
            first = left
        }
        if right < end && sort(nodes[right], nodes[first]) {
            first = right
        }

        if first == start {
            return
        }

        nodes.swapAt(start, first)
        bubbleDown(start: first, end: end)
    }

    private mutating func bubbleDown(_ index: Int) {
        bubbleDown(start: index, end: nodes.count)
    }
}
