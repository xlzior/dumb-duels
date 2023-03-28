//
//  Interpolatable.swift
//  DuelKit
//
//  Created by Esmanda Wong on 25/3/23.
//
import CoreGraphics

protocol Interpolatable {
    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: CGFloat) -> Self
    static func / (lhs: Self, rhs: CGFloat) -> Self
}

extension CGFloat: Interpolatable {}
