//
//  SPGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import UIKit
import DuelKit

class SPGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = SPGameManager(gameController: self)
    }

    override func styleGameViewBackground() {
        gameView.image = UIImage(imageLiteralResourceName: SPAssets.background)
    }
}
