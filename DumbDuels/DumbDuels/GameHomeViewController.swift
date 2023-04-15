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
        imageView.image = UIImage(named: "background")
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }

    override func loadGameIconsAndViewControllers() {
        gameLogo = "logo"
        gameIcons = ["axegame", "spaceshipgame", "tankgame", "soccergame"]
        gameViewControllers = [
            AXGameViewController(),
            SPGameViewController(),
            TAGameViewController(),
            SOGameViewController()
        ]
    }
}
