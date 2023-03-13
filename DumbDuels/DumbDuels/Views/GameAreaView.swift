//
//  GameAreaView.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 13/3/23.
//

import UIKit

class GameAreaView: UIView {
    let gameAspectRatio: CGFloat = 1_000 / 650

    init(screenSize: CGSize) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1_000, height: 650))
        style()
        letterBox(screenSize)
        position(screenSize)
    }

    private func style() {
        backgroundColor = .white
        layer.borderWidth = 10
        layer.borderColor = UIColor.black.cgColor
    }

    private func letterBox(_ screenSize: CGSize) {
        let screenAspectRatio = (screenSize.width * 0.9) / (screenSize.height * 0.8)
        let scalingFactor = screenAspectRatio > gameAspectRatio
            ? (screenSize.height * 0.8) / frame.height
            : (screenSize.width * 0.9) / frame.width
        transform = CGAffineTransform(scaleX: scalingFactor, y: scalingFactor)
    }

    private func position(_ screenSize: CGSize) {
        frame = CGRect(
            x: screenSize.width / 2 - frame.width / 2,
            y: screenSize.height * 0.05,
            width: frame.width,
            height: frame.height
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
