//
//  TTCollisions.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

struct TTCollisions {
    // landed blocks are for blocks that have already touched the platform
    // or other blcoks
    static let landedBlockBitmask: UInt32 = 0x1 << 0
    // This is for blocks that are still "in air" and under player input control

    // The reason for separation is so that we can only generate events between a controlBlock
    // and a landedBlock, preventing flooding of event queues where multiple block collisions
    // between landed blocks when they are many blocks on screen

    // Furthermore, this allows distinction in collision detection so that only landed blocks will
    // trigger the score line, while blocks that fall pass the score line will not trigger score
    static let controlBlockBitmask: UInt32 = 0x1 << 1
    static let platformBitmask: UInt32 = 0x1 << 2
    // this bitmask is used by both side and middle wall that has sprites (i.e. the separator)
    static let wallBitmask: UInt32 = 0x1 << 3
    static let bottomBoundaryBitmask: UInt32 = 0x1 << 4

    static let landedBlockCollideBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask | wallBitmask | platformBitmask
    static let controlBlockCollideBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask | wallBitmask | platformBitmask
    static let platformCollideBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask
    static let wallCollideBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask
    static let bottomBoundaryCollideBitmask: UInt32 = 0x0

    static let landedBlockContactBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask | wallBitmask | platformBitmask | bottomBoundaryBitmask
    static let controlBlockContactBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask | wallBitmask | platformBitmask |
                                                    bottomBoundaryBitmask
    static let platformContactBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask
    static let wallContactBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask
    static let bottomBoundaryContactBitmask: UInt32 = landedBlockBitmask | controlBlockBitmask
}
