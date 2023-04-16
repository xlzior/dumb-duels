//
//  SOAnimationCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 12/4/23.
//

import DuelKit
import CoreGraphics

class SOAnimationCreator {
    func createPlayerGoalAnimation(index: Int) -> AnimationComponent {
        let component = AnimationComponent(
            frames: [
                AnimationFrame(
                    frameDuration: 0.5,
                    spriteName: SOAssets.playersGoal[index]),
                AnimationFrame(
                    frameDuration: 0.01,
                    spriteName: SOAssets.players[index])],
            numRepeat: 0,
            isPlaying: false
        )
        return component
    }
}
