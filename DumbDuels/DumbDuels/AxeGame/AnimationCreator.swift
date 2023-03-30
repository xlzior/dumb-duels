//
//  AnimationCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 26/3/23.
//

import DuelKit
import CoreGraphics

class AnimationCreator {
    func createPlayerHitAnimation(index: Int) -> AnimationComponent {
        let component = AnimationComponent(
            isPlaying: false,
            frames: [
                AnimationFrame(
                    frameDuration: 0.5,
                    spriteName: Assets.playerHit[index]),
                AnimationFrame(
                    frameDuration: 0.01,
                    spriteName: Assets.player[index])],
            numRepeat: 0
        )
        return component
    }

    func createAxeParticleAnimation() -> AnimationComponent {
        let component = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0),
                AnimationFrame(
                    frameDuration: 0.55,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.15,
                    alpha: 1),
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0)],
            numRepeat: 0
        )
        return component
    }

    func createLavaSmokeAnimation() -> AnimationComponent {
        var randomXDeltas = [CGFloat]()
        var randomYDeltas = [CGFloat]()

        for _ in 1...4 {
            let randomXDelta = CGFloat.random(in: -1.5...1.5)
            let randomYDelta = CGFloat.random(in: 0.5...4)
            randomXDeltas.append(randomXDelta)
            randomYDeltas.append(randomYDelta)
        }

        let component = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.1,
                    alpha: 0,
                    deltaPosition: CGPoint(x: randomXDeltas[0], y: randomYDeltas[0])),
                AnimationFrame(
                    frameDuration: 0.3,
                    alpha: 1,
                    deltaPosition: CGPoint(x: randomXDeltas[1], y: randomYDeltas[1])),
                AnimationFrame(
                    frameDuration: 0.3,
                    alpha: 0.5,
                    deltaPosition: CGPoint(x: randomXDeltas[2], y: randomYDeltas[2])),
                AnimationFrame(
                    frameDuration: 0.3,
                    alpha: 0,
                    deltaPosition: CGPoint(x: randomXDeltas[3], y: randomYDeltas[3]))],
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
}
