//
//  Pair.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 13/3/23.
//

import Foundation
struct Pair<T, S> {
    var first: T
    var second: S
}

extension Pair: Equatable where T: Equatable, S: Equatable {}

extension Pair: Hashable where T: Hashable, S: Hashable {}
