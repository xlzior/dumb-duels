//
//  SPGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import DuelKit

class SPGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = SPGameManager(gameController: self)
    }

    override func styleGameViewBackground() {
        gameView.backgroundColor = .darkGray
    }
}
