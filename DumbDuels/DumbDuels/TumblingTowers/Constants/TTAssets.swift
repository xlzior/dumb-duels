//
//  TTAssets.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import Foundation

struct TTAssets {
    static let background = "tower-background"
    static let platform = "tower-platform"
    static let separator = "separator"
    static let scoreLine = "scoreline"
    static let guideline = "guideline"

    static let oneXOne = BlockType(width: 1, length: 1, assetName: "1x1")
    static let oneXTwo = BlockType(width: 1, length: 2, assetName: "1x2")
    static let oneXFour = BlockType(width: 1, length: 4, assetName: "1x4")
    static let twoXTwo = BlockType(width: 2, length: 2, assetName: "2x2")
    static let twoXThree = BlockType(width: 2, length: 3, assetName: "2x3")
    static let twoXFour = BlockType(width: 2, length: 4, assetName: "2x4")
    static let threeXThree = BlockType(width: 3, length: 3, assetName: "3x3")
    static let fourXFour = BlockType(width: 4, length: 4, assetName: "4x4")

    static func getRandomBlockType() -> BlockType {
        let randomPool = [oneXOne, oneXTwo, oneXFour, twoXTwo, twoXThree, twoXFour, threeXThree, fourXFour]
        return randomPool.randomElement() ?? randomPool[3]
    }
}

struct BlockType {
    let width: Int
    let length: Int
    let assetName: String
}
