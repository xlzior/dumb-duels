//
//  GameIconButton.swift
//  
//
//  Created by Esmanda Wong on 15/4/23.
//

import UIKit

class GameIconButton: UIButton {
    static var totalNumButtons = 0
    var totalNumButtons: Double {
        Double(GameIconButton.totalNumButtons)
    }

    let screenWidthPadding = 150.0
    let buttonPadding = 25.0
    var buttonWidth = 0.0
    var index: Int

    init(screenSize: CGSize, index: Int, icon: String) {
        self.index = index
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        scale(screenSize)
        position(screenSize, index)
        style(icon)
    }

    private func style(_ image: String) {
        layer.borderWidth = 5
        layer.borderColor = Colour.secondary.cgColour
        self.setImage(UIImage(named: image), for: .normal)
    }

    private func scale(_ screenSize: CGSize) {
        buttonWidth = min((screenSize.width - 150.0) / totalNumButtons - buttonPadding * 2, screenSize.height * 0.3)
        let scalingFactor = buttonWidth / frame.width
        transform = CGAffineTransform(scaleX: scalingFactor, y: scalingFactor)
    }

    private func position(_ screenSize: CGSize, _ index: Int) {
        let newScreenWidthPadding = screenSize.width - (buttonWidth + 2 * buttonPadding) * totalNumButtons
        let xPos = newScreenWidthPadding / 2 + buttonPadding + Double(index) * (buttonWidth + 2 * buttonPadding)
        frame = CGRect(
            x: xPos,
            y: screenSize.height * 0.55,
            width: frame.width,
            height: frame.height
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
