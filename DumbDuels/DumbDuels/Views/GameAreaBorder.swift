//
//  GameAreaBorder.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 20/3/23.
//

import UIKit

class GameAreaBorder: UIView {
    static let zPosition: CGFloat = 101

    init(screenSize: CGSize, gameAreaFrame: CGRect) {
        let origin = CGPoint()
        super.init(frame: CGRect(origin: origin, size: screenSize))
        addBorders(origin: origin, screenSize: screenSize, gameAreaFrame: gameAreaFrame)
        layer.zPosition = GameAreaBorder.zPosition
    }

    private func addBorders(origin: CGPoint, screenSize: CGSize, gameAreaFrame: CGRect) {
        var borders = [UIView]()
        let topBorder = UIView(frame: CGRect(
            origin: origin,
            size: CGSize(width: screenSize.width, height: gameAreaFrame.minY)
        ))
        let bottomBorder = UIView(frame: CGRect(
            origin: CGPoint(x: 0, y: gameAreaFrame.maxY),
            size: CGSize(width: screenSize.width, height: screenSize.width - gameAreaFrame.maxY)
        ))
        let leftBorder = UIView(frame: CGRect(
            origin: origin,
            size: CGSize(width: gameAreaFrame.minX, height: screenSize.height)
        ))
        let rightBorder = UIView(frame: CGRect(
            origin: CGPoint(x: gameAreaFrame.maxX, y: 0),
            size: CGSize(width: screenSize.width - gameAreaFrame.maxX, height: screenSize.height)
        ))
        borders.append(contentsOf: [topBorder, bottomBorder, leftBorder, rightBorder])
        for border in borders {
            border.backgroundColor = Colour.primary.uiColour
            addSubview(border)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
