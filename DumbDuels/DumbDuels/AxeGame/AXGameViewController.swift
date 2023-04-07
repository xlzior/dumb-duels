//
//  AXGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import DuelKit

class AXGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = AXGameManager(gameController: self)
    }
}
