//
//  Sound.swift
//  
//
//  Created by Esmanda Wong on 8/4/23.
//

import Foundation

public protocol Sound: AnyObject {
    var isPlaying: Bool { get set }
    var url: URL { get }
    var volume: Float { get }
    var numLoop: Int { get }
}

extension Sound {
    public func play() {
        self.isPlaying = true
    }

    public func stop() {
        self.isPlaying = false
    }
}
