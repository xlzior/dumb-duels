//
//  PlayerButton.swift
//  DuelKit
//
//  Created by Esmanda Wong on 13/3/23.
//

import UIKit

class PlayerButton: UIButton {
    static let zPosition: CGFloat = 101
    let buttonAspectRatio = 1.8
    var isPlayerOne: Bool
    var playerID: EntityID?

    init(screenSize: CGSize, isPlayerOne: Bool) {
        self.isPlayerOne = isPlayerOne
        super.init(frame: CGRect(x: 0, y: 0, width: 180, height: 100))

        scale(screenSize.height)
        position(screenSize, isPlayerOne)
        style()
    }

    private func style() {
        backgroundColor = Colour.secondary.uiColour
        layer.borderWidth = 10
        layer.cornerRadius = frame.height / 3
        layer.borderColor = Colour.secondaryDark.cgColour
        layer.zPosition = PlayerButton.zPosition
    }

    private func scale(_ screenHeight: CGFloat) {
        let scalingFactor = screenHeight * 0.1 / frame.height
        transform = CGAffineTransform(scaleX: scalingFactor, y: scalingFactor)
    }

    private func position(_ screenSize: CGSize, _ isPlayerOne: Bool) {
        let xPos = isPlayerOne
            ? screenSize.width * 0.05
            : screenSize.width * 0.95 - frame.width
        frame = CGRect(
            x: xPos,
            y: screenSize.height * 0.85,
            width: frame.width,
            height: frame.height
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
