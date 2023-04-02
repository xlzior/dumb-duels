//
//  SPAnimationCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 29/3/23.
//

import Foundation
import DuelKit

class SPAnimationCreator {
    func createAccelerationParticle() -> AnimationComponent {
        let component = AnimationComponent(
            isPlaying: true,
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0),
                AnimationFrame(
                    frameDuration: 0.55,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0)],
            numRepeat: 0
        )
        return component
    }

    func createSpaceshipParticleAnimation(deltaPosition: CGPoint, travelTime: CGFloat) -> AnimationComponent {
        let component = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0,
                    deltaPosition: .zero),
                AnimationFrame(
                    frameDuration: travelTime,
                    alpha: 1,
                    deltaPosition: deltaPosition),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0,
                    deltaPosition: .zero)],
            numRepeat: 0
        )
        return component
    }

    func createBattleFlashAnimation() -> AnimationComponent {
        let component = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.05,
                    alpha: 0)],
            numRepeat: 2
        )
        return component
    }

    func createStarAnimation(initialPosition: CGPoint) -> AnimationComponent {
        let initialAlpha = CGFloat.random(in: 0...0.5)
        // How much alpha to increase or decrease within 1s interval
        let alphaChangeRate = CGFloat.random(in: 0.5...1.0)
        let velocity = CGPoint(x: CGFloat.random(in: 0.5...1.5), y: 0)

        let component = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: (1.0 - initialAlpha) / alphaChangeRate,
                    alpha: initialAlpha,
                    deltaPosition: (1.0 - initialAlpha) * velocity / alphaChangeRate),
                AnimationFrame(
                    frameDuration: 1.0 / alphaChangeRate,
                    alpha: 1.0,
                    deltaPosition: 1.0 * velocity / alphaChangeRate),
                AnimationFrame(
                    frameDuration: initialAlpha / alphaChangeRate,
                    alpha: 0.0,
                    deltaPosition: initialAlpha * velocity / alphaChangeRate)],
            numRepeat: 50
        )
        return component
    }
}
