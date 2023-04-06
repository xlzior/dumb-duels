//
//  SOGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit

class SOGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = SOGameManager(gameController: self)
    }
}
