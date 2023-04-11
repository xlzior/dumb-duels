//
//  TTSizes.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

struct TTSizes {
    static let separatorSize = CGSize(width: 70, height: Sizes.game.height)

    static let wallSize = CGSize(width: 50, height: Sizes.game.height)

    static let platformSize = CGSize(width: Sizes.game.width / 3.0,
                                     height: 0.1 * Sizes.game.height)

    // Let the platform be able to hold 16-unit length
    static let blockUnitSize: CGFloat = platformSize.width / 10.0

    static let scoreLineSize = CGSize(width: Sizes.game.width / 2, height: 20)
}
