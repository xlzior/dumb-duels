//
//  Date.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 23/3/23.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
