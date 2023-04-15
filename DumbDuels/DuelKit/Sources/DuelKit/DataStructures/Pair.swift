//
//  Pair.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

public struct Pair<T, S> {
    public var first: T
    public var second: S

    public init(_ first: T, _ second: S) {
        self.first = first
        self.second = second
    }
}

extension Pair: Equatable where T: Equatable, S: Equatable {}

extension Pair: Hashable where T: Hashable, S: Hashable {}
