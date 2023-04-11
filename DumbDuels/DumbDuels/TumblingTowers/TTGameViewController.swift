//
//  TTGameViewController.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import UIKit
import DuelKit

class TTGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = TTGameManager(gameController: self)
    }

    override func customiseBackgroundViewAndSound() {
        gameView.image = UIImage(imageLiteralResourceName: TTAssets.background)
        backgroundSound = GameBackgroundSound()
    }
}
