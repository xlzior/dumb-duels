//
//  GameHomeViewController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 15/4/23.
//

import DuelKit
import UIKit

class GameHomeViewController: HomeViewController {
    override func styleBackground() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }

    override func loadGameIconsAndViewControllers() {
        gameLogo = "logo"
        gameIcons = ["axegame", "spaceshipgame", "tankgame", "soccergame", "tumblingtowersgame"]
        let axController = { AXGameViewController() }
        let spController = { SPGameViewController() }
        let taController = { TAGameViewController() }
        let soController = { SOGameViewController() }
        let ttController = { TTGameViewController() }
        gameViewControllers = [axController, spController, taController, soController, ttController]
    }
}
