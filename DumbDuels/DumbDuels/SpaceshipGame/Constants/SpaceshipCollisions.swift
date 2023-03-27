//
//  SpaceshipCollisions.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

class SpaceshipCollisions {
    static let spaceshipBitmask: UInt32 = 0x1 << 0
    static let rockBitmask: UInt32 = 0x1 << 1
    static let bulletBitmask: UInt32 = 0x1 << 2

    static let spaceshipCollideBitmask: UInt32 = spaceshipBitmask | rockBitmask
    static let rockCollideBitmask: UInt32 = spaceshipBitmask | rockBitmask
    static let bulletCollideBitmask: UInt32 = 0

    static let spaceshipContactBitmask: UInt32 = rockBitmask | bulletBitmask
    static let rockContactBitmask: UInt32 = spaceshipBitmask
    static let bulletContactBitmask: UInt32 = spaceshipBitmask
}
