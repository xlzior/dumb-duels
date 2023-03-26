//
//  Date.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 23/3/23.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
