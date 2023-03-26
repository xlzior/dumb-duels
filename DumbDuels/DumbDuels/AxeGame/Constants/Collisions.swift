//
//  Collisions.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation

class Collisions {
    static let playerBitmask: UInt32 = 0x1 << 0
    static let axeBitmask: UInt32 = 0x1 << 1
    static let platformBitmask: UInt32 = 0x1 << 2
    static let pegBitmask: UInt32 = 0x1 << 3
    static let wallBitmask: UInt32 = 0x1 << 4

    static let playerCollideBitmask: UInt32 = axeBitmask | platformBitmask | wallBitmask
    static let axeCollideBitmask: UInt32 = playerBitmask | axeBitmask | pegBitmask | wallBitmask
    static let platformCollideBitmask: UInt32 = playerBitmask | wallBitmask
    static let pegCollideBitmask: UInt32 = axeBitmask | wallBitmask
    static let wallCollideBitmask: UInt32 = playerBitmask | axeBitmask | platformBitmask | pegBitmask

    static let playerContactBitmask: UInt32 = axeBitmask | platformBitmask | wallBitmask
    static let axeContactBitmask: UInt32 = playerBitmask | axeBitmask | pegBitmask | wallBitmask
    static let platformContactBitmask: UInt32 = playerBitmask | wallBitmask
    static let pegContactBitmask: UInt32 = axeBitmask | wallBitmask
    static let wallContactBitmask: UInt32 = playerBitmask | axeBitmask | platformBitmask | pegBitmask

    private static func unionBitmasks(_ bitmasks: [UInt32]) -> UInt32 {
        var result: UInt32 = 0x00000000
        for bitmask in bitmasks {
            result = result | bitmask
        }
        return result
    }
}
