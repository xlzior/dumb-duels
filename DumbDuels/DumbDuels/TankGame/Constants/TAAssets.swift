//
//  TAAssets.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

struct TAAssets {
    static func tankSprite(index: Int, charging: Int) -> String {
        "tank-\(index)-\(charging)"
    }

    static let cannonball = "cannonball"

    static let cannonballFire = "ball-fire"

    static let wall = "wall"

    static let background = "tank-background"

    static let particles = [
        ["red-0-1", "red-0-4", "grey-particle"],
        ["blue-1-1", "blue-1-4", "grey-particle"]
    ]
}
