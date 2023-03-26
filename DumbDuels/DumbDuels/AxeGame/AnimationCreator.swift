//
//  AnimationCreator.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 26/3/23.
//

class AnimationCreator {
    func createPlayerHitAnimation() -> AnimationComponent {
        let component = AnimationComponent(
            isPlaying: false,
            frames: [
                AnimationFrame(
                    frameDuration: 0.5,
                    spriteName: "player-flash"),
                AnimationFrame(
                    frameDuration: 0.01,
                    spriteName: "player")],
            numRepeat: 0
        )
        return component
    }

    func createBattleFlashAnimation() -> AnimationComponent {
        let component = AnimationComponent(
            shouldDestroyEntityOnEnd: true,
            frames: [
                AnimationFrame(
                    frameDuration: 0.05,
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
