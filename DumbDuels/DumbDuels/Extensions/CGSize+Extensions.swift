//
//  File.swift
//  
//
//  Created by Bing Sen Lim on 30/3/23.
//

import Foundation

extension CGSize {
    static func - (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width - right.width, height: left.height - right.height)
    }
}
