//
//  TAGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import DuelKit

class TAGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = TAGameManager(gameController: self)
    }
}
