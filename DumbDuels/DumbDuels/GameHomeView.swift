//
//  GameHomeViewController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 15/4/23.
//

import DuelKit
import UIKit

class GameHomeView: HomeViewDelegate {
    var homeView: HomeViewController

    init(homeView: HomeViewController) {
        self.homeView = homeView
        homeView.homeViewDelegate = self
    }

    func styleBackground(view: UIView) {
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "background")
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }

    func loadGameIconsAndViewControllers(_ homeView: HomeViewController) {
        homeView.gameLogo = "logo"
        homeView.gameIcons = ["axegame", "spaceshipgame", "tankgame", "soccergame", "tumblingtowersgame"]
        let axController = { AXGameViewController() }
        let spController = { SPGameViewController() }
        let taController = { TAGameViewController() }
        let soController = { SOGameViewController() }
        let ttController = { TTGameViewController() }
        homeView.gameViewControllers = [axController, spController, taController, soController, ttController]
    }

}
