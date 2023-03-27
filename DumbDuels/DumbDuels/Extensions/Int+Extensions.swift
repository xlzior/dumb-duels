//
//  Int+Extensions.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 27/3/23.
//

import Foundation

extension Int {
    static func * (left: Int, right: Double) -> Double {
        Double(left) * right
    }

    static func * (left: Double, right: Int) -> Double {
        left * Double(right)
    }
}
