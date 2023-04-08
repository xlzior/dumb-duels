//
//  Sound.swift
//  
//
//  Created by Esmanda Wong on 8/4/23.
//

import Foundation

public class Sound {
    public var isPlaying: Bool
    public var url: URL

    public init(isPlaying: Bool = false, url: URL) {
        self.isPlaying = isPlaying
        self.url = url
    }
}
