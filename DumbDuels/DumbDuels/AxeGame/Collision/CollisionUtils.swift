//
//  CollisionUtils.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class ColliisionUtils {
    static let playerBitmask: UInt32 =  0x1 << 0
    static let axeBitmask: UInt32 =  0x1 << 1
    static let platformBitmask: UInt32 = 0x1 << 2
    static let pegBitmask: UInt32 = 0x1 << 3

    static let playerCollideBitmask: UInt32 = axeBitmask | platformBitmask
    static let axeCollideBitmask: UInt32 = playerBitmask | axeBitmask | pegBitmask
    static let platformCollideBitmask: UInt32 = playerBitmask
    static let pegCollideBitmask: UInt32 = axeBitmask

    static let playerContactBitmask: UInt32 = axeBitmask | platformBitmask
    static let axeContactBitmask: UInt32 = playerBitmask | axeBitmask | pegBitmask
    static let platformContactBitmask: UInt32 = playerBitmask
    static let pegContactBitmask: UInt32 = axeBitmask

    static func bitmasks(for categories: [CollisionCategory]) -> UInt32 {
        unionBitmasks(categories.map({ $0.ownBitmask }))
    }

    static func collideBitmasks(for categories: [CollisionCategory]) -> UInt32 {
        unionBitmasks(categories.map({ $0.collideBitmask }))
    }

    static func contactBitmasks(for categories: [CollisionCategory]) -> UInt32 {
        unionBitmasks(categories.map({ $0.contactBitmask }))
    }

    private static func unionBitmasks(_ bitmasks: [UInt32]) -> UInt32 {
        var result: UInt32 = 0x00000000
        for bitmask in bitmasks {
            result = result | bitmask
        }
        return result
    }
}
