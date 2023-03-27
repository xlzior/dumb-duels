//
//  Colour.swift
//  DuelKit
//
//  Created by Esmanda Wong on 12/3/23.
//

import UIKit

enum Colour {
    case primary
    case secondary
    case secondaryDark

    var uiColour: UIColor {
        let colours: [Colour: UIColor] = [
            .primary: #colorLiteral(red: 227 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1),
            .secondary: #colorLiteral(red: 229 / 255, green: 110 / 255, blue: 82 / 255, alpha: 1),
            .secondaryDark: #colorLiteral(red: 84 / 255, green: 84 / 255, blue: 84 / 255, alpha: 0.5)
        ]
        return colours[self] ?? UIColor()
    }

    var cgColour: CGColor {
        uiColour.cgColor
    }
}
