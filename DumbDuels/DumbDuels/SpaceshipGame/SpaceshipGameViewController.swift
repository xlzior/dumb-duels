//
//  SpaceshipGameViewController.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 26/3/23.
//

import DuelKit

class SpaceshipGameViewController: GameViewController {
    override func setUpGameManager() {
        guard let renderSystemDetails else {
            return assertionFailure("RenderSystemDetails was not populated")
        }
        gameManager = SpaceshipGameManager(renderSystemDetails: renderSystemDetails)
    }
}
