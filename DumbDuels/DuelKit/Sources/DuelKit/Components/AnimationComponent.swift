//
//  AnimationComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 24/3/23.
//

import CoreGraphics

public class AnimationComponent: ComponentInitializable {
    public var id: ComponentID
    public var isPlaying: Bool
    public var shouldDestroyEntityOnEnd: Bool

    public var animationFrames: [AnimationFrame]
    public var currentFrameIdx: Int
    public var timeElapsedForCurrentFrame: Double

    var nextFrameIdx: Int {
        let nextIdx = currentFrameIdx + 1
        return nextIdx < animationFrames.count ? nextIdx : 0
    }
    var originalNumRepeat: Int
    var numRepeat: Int

    public required init() {
        self.id = ComponentID()
        self.isPlaying = false
        self.shouldDestroyEntityOnEnd = false

        self.animationFrames = []
        self.currentFrameIdx = 0
        self.originalNumRepeat = 0
        self.numRepeat = 0
        self.timeElapsedForCurrentFrame = 0
    }

    public init(frames: [AnimationFrame], numRepeat: Int, isPlaying: Bool = true,
                shouldDestroyEntityOnEnd: Bool = false, currentFrameIdx: Int = 0, timeElapsed: Double = 0) {
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
