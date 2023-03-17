//
//  CategoryTypeBitMasks.swift
//  DumbDuels
//
//  Created by Bryan Kwok on 17/3/23.
//

import Foundation

struct CategoryTypeBitMasks {
    static let categoryTypeBitMaskMap: [ObjectIdentifier: UInt32] = [
        ObjectIdentifier(PlayerCategory.self): 0x1 << 0,
        ObjectIdentifier(AxeCategory.self): 0x1 << 1,
        ObjectIdentifier(PlatformCategory.self): 0x1 << 2,
        ObjectIdentifier(PegCategory.self): 0x1 << 3
    ]

    static func getBitMask(for categories: [any CollisionCategory]) -> UInt32 {
        var bitMask: UInt32 = 0x00000000
        for category in categories {
            let nextBitMask = categoryTypeBitMaskMap[ObjectIdentifier(category.self)] ?? 0
            bitMask = bitMask | nextBitMask
        }
        return bitMask
    }
}
