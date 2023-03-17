//
//  CollisionTypeBitMasks.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

struct CollisionTypeBitMasks {
    static let collisionTypeBitMaskMap: [ObjectIdentifier: UInt32] = [
        ObjectIdentifier(PlayerCategory.self):
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(AxeCategory.self)] ?? 0) |
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(PlatformCategory.self)] ?? 0),
        ObjectIdentifier(AxeCategory.self):
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(PlayerCategory.self)] ?? 0) |
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(AxeCategory.self)] ?? 0) |
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(PegCategory.self)] ?? 0),
        ObjectIdentifier(PlatformCategory.self):
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(PlayerCategory.self)] ?? 0),
        ObjectIdentifier(PegCategory.self):
            (CategoryTypeBitMasks.categoryTypeBitMaskMap[ObjectIdentifier(AxeCategory.self)] ?? 0)
    ]

    static func getBitMask(for categories: [any CollisionCategory]) -> UInt32 {
        var bitMask: UInt32 = 0x00000000
        for category in categories {
            let nextBitMask = collisionTypeBitMaskMap[ObjectIdentifier(category.self)] ?? 0
            bitMask = bitMask | nextBitMask
        }
        return bitMask
    }
}
