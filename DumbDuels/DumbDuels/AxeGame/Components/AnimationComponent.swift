//
//  AnimationComponent.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 24/3/23.
//

import CoreGraphics

class AnimationComponent: ComponentInitializable {
    var id: ComponentID
    var isPlaying: Bool
    var shouldDestroyEntityOnEnd: Bool

    var animationFrames: [AnimationFrame]
    var currentFrameIdx: Int
    var nextFrameIdx: Int {
        let nextIdx = currentFrameIdx + 1
        return nextIdx < animationFrames.count ? nextIdx : 0
    }
    var originalNumRepeat: Int
    var numRepeat: Int
    var timeElapsedForCurrentFrame: Double

    required init() {
        self.id = ComponentID()
        self.isPlaying = false
        self.shouldDestroyEntityOnEnd = false

        self.animationFrames = []
        self.currentFrameIdx = 0
        self.originalNumRepeat = 0
        self.numRepeat = 0
        self.timeElapsedForCurrentFrame = 0
    }

    init(isPlaying: Bool = true, shouldDestroyEntityOnEnd: Bool = false, frames: [AnimationFrame],
         currentFrameIdx: Int = 0, numRepeat: Int, timeElapsed: Double = 0) {
        self.id = ComponentID()
        self.isPlaying = isPlaying
        self.shouldDestroyEntityOnEnd = shouldDestroyEntityOnEnd

        self.animationFrames = frames
        self.currentFrameIdx = currentFrameIdx
        self.originalNumRepeat = numRepeat
        self.numRepeat = numRepeat
        self.timeElapsedForCurrentFrame = timeElapsed
    }
}
