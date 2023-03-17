//
//  ScoreLabel.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 17/3/23.
//

import UIKit

class ScoreLabel: UILabel {
    var isPlayerOne: Bool

    init(screenSize: CGSize, isPlayerOne: Bool, score: Int = 0) {
        self.isPlayerOne = isPlayerOne
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        text = String(score)

        scale(screenSize.height)
        position(screenSize, isPlayerOne)
        style()
    }

    private func style() {
        textColor = Colour.secondary.uiColour
        font = UIFont.systemFont(ofSize: 100.0, weight: UIFont.Weight.heavy)
        textAlignment = .center
        numberOfLines = 0
        sizeToFit()
    }

    private func scale(_ screenHeight: CGFloat) {
        let scalingFactor = screenHeight * 0.1 / frame.height
        transform = CGAffineTransform(scaleX: scalingFactor, y: scalingFactor)
    }

    private func position(_ screenSize: CGSize, _ isPlayerOne: Bool) {
        let xPos = isPlayerOne
            ? screenSize.width * 0.35
            : screenSize.width * 0.65 - frame.width
        frame = CGRect(
            x: xPos,
            y: screenSize.height * 0.85,
            width: frame.width,
            height: frame.height
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
