//
//  AnimationSystem.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 24/3/23.
//

import Foundation
import CoreGraphics

class AnimationSystem: System {
    unowned var entityManager: EntityManager
    var prevTime: Date = Date()

    var animatables: Assemblage5<
        AnimationComponent, SpriteComponent, PositionComponent, SizeComponent, RotationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.animatables = entityManager.assemblage(requiredComponents: AnimationComponent.self,
            SpriteComponent.self, PositionComponent.self, SizeComponent.self, RotationComponent.self)
    }

    func update() {
        let currentTime = Date()
        let timeElapsed = currentTime.timeIntervalSince(prevTime)
        prevTime = currentTime
//        print(animatables.count)

        for (entity, animation, sprite, position, size, rotation) in animatables.entityAndComponents {
            guard animation.isPlaying else {
                continue
            }

            var animationTimeElapsed = animation.timeElapsedForCurrentFrame + timeElapsed
            let currentFrameDuration = animation.animationFrames[animation.currentFrameIdx].frameDuration
            if animationTimeElapsed >= currentFrameDuration {
                animationTimeElapsed -= currentFrameDuration
                let nextIdx = (animation.currentFrameIdx + 1) % animation.animationFrames.count
                animation.currentFrameIdx = nextIdx
                if nextIdx == 0 {
                    // Wrap around
                    animation.numRepeat -= 1
                }
            }
            animation.timeElapsedForCurrentFrame = animationTimeElapsed

            guard animation.numRepeat >= 0 else {
                animation.isPlaying = false
                animation.numRepeat = animation.originalNumRepeat
                if animation.shouldDestroyEntityOnEnd {
                    entityManager.destroy(entity: entity)
                }
                continue
            }

            interpolateAnimation(
                animation: animation,
                sprite: sprite,
                position: position,
                size: size,
                rotation: rotation)
        }
    }

    private func interpolateAnimation(
        animation: AnimationComponent,
        sprite: SpriteComponent,
        position: PositionComponent,
        size: SizeComponent,
        rotation: RotationComponent) {
        // TODO: only interpolate if exist
        let currentFrame = animation.animationFrames[animation.currentFrameIdx]
        let nextFrame = animation.animationFrames[animation.nextFrameIdx]
        let timeElapsed = animation.timeElapsedForCurrentFrame

        sprite.assetName = currentFrame.spriteName
        sprite.alpha = interpolate(
            previousValue: currentFrame.alpha,
            nextValue: nextFrame.alpha,
            timeElapsed: timeElapsed,
            frameDuration: currentFrame.frameDuration)
        position.position = interpolate(
            previousValue: currentFrame.position,
            nextValue: nextFrame.position,
            timeElapsed: timeElapsed,
            frameDuration: currentFrame.frameDuration)
        size.xScale = interpolate(
            previousValue: currentFrame.xScale,
            nextValue: nextFrame.xScale,
            timeElapsed: timeElapsed,
            frameDuration: currentFrame.frameDuration)
        size.yScale = interpolate(
            previousValue: currentFrame.yScale,
            nextValue: nextFrame.yScale,
            timeElapsed: timeElapsed,
            frameDuration: currentFrame.frameDuration)
        rotation.angleInRadians = interpolate(
            previousValue: currentFrame.rotationAngle,
            nextValue: nextFrame.rotationAngle,
            timeElapsed: timeElapsed,
            frameDuration: currentFrame.frameDuration)
    }

    private func interpolate<T: Interpolatable>(
        previousValue: T,
        nextValue: T,
        timeElapsed: CGFloat,
        frameDuration: CGFloat) -> T {
        previousValue + (nextValue - previousValue) * timeElapsed / frameDuration
    }
}
