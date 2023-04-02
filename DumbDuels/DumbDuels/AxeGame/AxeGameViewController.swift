//
//  AxeGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import DuelKit

class AxeGameViewController: GameViewController {
    override func setUpGameManager() {
        gameManager = AxeGameManager(gameController: self)
    }
}
