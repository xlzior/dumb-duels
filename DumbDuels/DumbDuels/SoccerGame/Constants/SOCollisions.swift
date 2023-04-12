//
//  SOCollisions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

struct SOCollisions {
    static let playerBitmask: UInt32 = 0x1 << 0
    static let ballBitmask: UInt32 = 0x1 << 1
    static let goalSideBitmask: UInt32 = 0x1 << 2
    static let goalBackBitmask: UInt32 = 0x1 << 3
    static let goalBitmask: UInt32 = 0x1 << 4
    static let wallBitmask: UInt32 = 0x1 << 5

    static let playerCollideBitmask: UInt32 = playerBitmask | ballBitmask | goalBitmask | wallBitmask
    static let ballCollideBitmask: UInt32 = playerBitmask | goalSideBitmask | goalBackBitmask | wallBitmask
    static let goalBackCollideBitmask: UInt32 = ballBitmask
    static let goalSideCollideBitmask: UInt32 = ballBitmask
    static let goalCollideBitmask: UInt32 = playerBitmask
    static let wallCollideBitmask: UInt32 = playerBitmask | ballBitmask

    static let playerContactBitmask: UInt32 = ballBitmask | wallBitmask
    static let ballContactBitmask: UInt32 = goalBackBitmask | playerBitmask | wallBitmask
    static let goalBackContactBitmask: UInt32 = ballBitmask
    static let goalSideContactBitmask: UInt32 = 0
    static let goalContactBitmask: UInt32 = 0
    static let wallContactBitmask: UInt32 = playerBitmask | ballBitmask
}
