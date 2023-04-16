//
//  AXGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import UIKit
import DuelKit
import AVFoundation

class AXGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = AXGameManager(gameController: self)
    }

    override func customiseBackgroundViewAndSound() {
        gameViewImage = UIImage(imageLiteralResourceName: AXAssets.background)
        backgroundSound = GameBackgroundSound()
    }
}
