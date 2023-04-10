//
//  AnimationSystem.swift
//  DuelKit
//
//  Created by Esmanda Wong on 24/3/23.
//

import Foundation
import CoreGraphics

class AnimationSystem: System {
    unowned var entityManager: EntityManager
    var prevTime: Date

    var animatables: Assemblage5<
        AnimationComponent, SpriteComponent, PositionComponent, SizeComponent, RotationComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.prevTime = Date()
        self.animatables = entityManager.assemblage(requiredComponents: AnimationComponent.self,
                                                    SpriteComponent.self, PositionComponent.self,
                                                    SizeComponent.self, RotationComponent.self)
    }

    func update() {
        let currentTime = Date()
        let timeElapsed = currentTime.timeIntervalSince(prevTime)
        prevTime = currentTime

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
                resetAnimationComponent(animation)
                if animation.shouldDestroyEntityOnEnd {
                    guard let physics: PhysicsComponent = entityManager.getComponent(
                        ofType: PhysicsComponent.typeId, for: entity.id) else {
                        entityManager.destroy(entity: entity)
                        continue
                    }
                    physics.toBeRemoved = true
                    physics.shouldDestroyEntityWhenRemove = true
                }
                continue
            }

            interpolateAnimation(
                timeElapsed: timeElapsed,
                animation: animation,
                sprite: sprite,
                position: position,
                size: size,
                rotation: rotation)
        }
    }

    private func resetAnimationComponent(_ animation: AnimationComponent) {
        animation.isPlaying = false
        animation.numRepeat = animation.originalNumRepeat
        animation.currentFrameIdx = 0
        animation.timeElapsedForCurrentFrame = 0
    }

    private func interpolateAnimation(
        timeElapsed: CGFloat,
        animation: AnimationComponent,
        sprite: SpriteComponent,
        position: PositionComponent,
        size: SizeComponent,
        rotation: RotationComponent) {
        let currentFrame = animation.animationFrames[animation.currentFrameIdx]
        let nextFrame = animation.animationFrames[animation.nextFrameIdx]
        let animationTimeElapsed = animation.timeElapsedForCurrentFrame

        if let spriteName = currentFrame.spriteName {
            sprite.assetName = spriteName
        }

        if let alpha = currentFrame.alpha, let nextAlpha = nextFrame.alpha {
            sprite.alpha = interpolate(
                previousValue: alpha,
                nextValue: nextAlpha,
                timeElapsed: animationTimeElapsed,
                frameDuration: currentFrame.frameDuration)
        }

        if let deltaPosition = currentFrame.deltaPosition {
            position.position += interpolate(
                previousValue: CGPoint(x: 0, y: 0),
                nextValue: deltaPosition,
                timeElapsed: timeElapsed,
                frameDuration: currentFrame.frameDuration)
        }

        if let xScale = currentFrame.xScale, let nextXScale = nextFrame.xScale {
            size.xScale = interpolate(
                previousValue: xScale,
                nextValue: nextXScale,
                timeElapsed: animationTimeElapsed,
                frameDuration: currentFrame.frameDuration)
        }

        if let yScale = currentFrame.yScale, let nextYScale = nextFrame.yScale {
            size.yScale = interpolate(
                previousValue: yScale,
                nextValue: nextYScale,
                timeElapsed: animationTimeElapsed,
                frameDuration: currentFrame.frameDuration)
        }

        if let rotationAngle = currentFrame.rotationAngle, let nextRotationAngle = nextFrame.rotationAngle {
            rotation.angleInRadians = interpolate(
                previousValue: rotationAngle,
                nextValue: nextRotationAngle,
                timeElapsed: animationTimeElapsed,
                frameDuration: currentFrame.frameDuration)
        }
    }

    private func interpolate<T: Interpolatable>(
        previousValue: T,
        nextValue: T,
        timeElapsed: CGFloat,
        frameDuration: CGFloat) -> T {
        previousValue + (nextValue - previousValue) * timeElapsed / frameDuration
    }
}
