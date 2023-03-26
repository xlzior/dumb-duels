//
//  Pair.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

public struct Pair<T, S> {
    var first: T
    var second: S

    public init(first: T, second: S) {
        self.first = first
        self.second = second
    }
}

extension Pair: Equatable where T: Equatable, S: Equatable {}

extension Pair: Hashable where T: Hashable, S: Hashable {}
