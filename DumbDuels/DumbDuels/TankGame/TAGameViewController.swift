//
//  TAGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import UIKit
import DuelKit

class TAGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = TAGameManager(gameController: self)
    }

    override func customiseBackgroundViewAndSound() {
        gameView.image = UIImage(imageLiteralResourceName: TAAssets.background)
    }
}
