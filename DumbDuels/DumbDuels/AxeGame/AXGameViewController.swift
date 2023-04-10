//
//  AXGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import UIKit
import DuelKit

class AXGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = AXGameManager(gameController: self)
    }

    override func styleGameViewBackground() {
        gameView.image = UIImage(imageLiteralResourceName: AXAssets.background)
    }
}
