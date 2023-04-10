//
//  TACollisions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

struct TACollisions {
    static let tankBitmask: UInt32 = 0x1 << 0
    static let cannonballBitmask: UInt32 = 0x1 << 1
    static let wallBitmask: UInt32 = 0x1 << 2
    static let sideWallBitmask: UInt32 = 0x1 << 3

    static let tankCollideBitmask: UInt32 = tankBitmask | wallBitmask | sideWallBitmask
    static let cannonballCollideBitmask: UInt32 = wallBitmask | sideWallBitmask
    static let wallCollideBitmask: UInt32 = tankBitmask | cannonballBitmask
    static let sideWallCollideBitmask: UInt32 = tankBitmask | cannonballBitmask

    static let tankContactBitmask: UInt32 = cannonballBitmask
    static let cannonballContactBitmask: UInt32 = tankBitmask
    static let wallContactBitmask: UInt32 = 0
    static let sideWallContactBitmask: UInt32 = 0
}
