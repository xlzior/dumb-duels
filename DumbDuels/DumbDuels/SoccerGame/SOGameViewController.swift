//
//  SOGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import UIKit
import DuelKit

class SOGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = SOGameManager(gameController: self)
    }

    override func customiseBackgroundViewAndSound() {
        gameView.image = UIImage(imageLiteralResourceName: SOAssets.background)
        backgroundSound = SoccerCrowdSound()
    }
}
