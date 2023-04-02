//
//  GameAreaBorder.swift
//  DuelKit
//
//  Created by Esmanda Wong on 20/3/23.
//

import UIKit

class GameAreaBorder: UIView {
    static let zPosition: CGFloat = 101
    let outlineThickness = CGFloat(10)

    init(screenSize: CGSize, gameAreaFrame: CGRect) {
        let origin = CGPoint()
        super.init(frame: CGRect(origin: origin, size: screenSize))
        addBorders(origin: origin, screenSize: screenSize, gameAreaFrame: gameAreaFrame)
        addOutline(gameAreaFrame: gameAreaFrame)
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
            size: CGSize(width: screenSize.width, height: screenSize.height - gameAreaFrame.maxY)
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

    private func addOutline(gameAreaFrame: CGRect) {
        let outlineHeight = gameAreaFrame.height + 2 * outlineThickness
        let outlineWidth = gameAreaFrame.width + 2 * outlineThickness

        var outlines = [UIView]()
        let topOutline = UIView(frame: CGRect(
            origin: CGPoint(x: gameAreaFrame.minX - outlineThickness, y: gameAreaFrame.minY - outlineThickness),
            size: CGSize(width: outlineWidth, height: outlineThickness)
        ))
        let bottomOutline = UIView(frame: CGRect(
            origin: CGPoint(x: gameAreaFrame.minX - outlineThickness, y: gameAreaFrame.maxY),
            size: CGSize(width: outlineWidth, height: outlineThickness)
        ))
        let leftOutline = UIView(frame: CGRect(
            origin: CGPoint(x: gameAreaFrame.minX - outlineThickness, y: gameAreaFrame.minY - outlineThickness),
            size: CGSize(width: outlineThickness, height: outlineHeight)
        ))
        let rightOutline = UIView(frame: CGRect(
            origin: CGPoint(x: gameAreaFrame.maxX, y: gameAreaFrame.minY - outlineThickness),
            size: CGSize(width: outlineThickness, height: outlineHeight)
        ))
        outlines.append(contentsOf: [topOutline, bottomOutline, leftOutline, rightOutline])
        for outline in outlines {
            outline.backgroundColor = Colour.secondary.uiColour
            addSubview(outline)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
