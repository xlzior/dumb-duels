//
//  GameViewController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 11/3/23.
//

import UIKit

class GameViewController: UIViewController {
    var gameView: UIView!
    var playerOneButton: UIButton!
    var playerTwoButton: UIButton!

    var screenSize: CGSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGameViewAndPlayerButtons()
    }

    func setUpGameViewAndPlayerButtons() {
        gameView = GameAreaView(screenSize: screenSize)
        view.addSubview(gameView)

        playerOneButton = PlayerButton(screenSize: screenSize, isPlayerOne: true)
        playerTwoButton = PlayerButton(screenSize: screenSize, isPlayerOne: false)
        view.addSubview(playerOneButton)
        view.addSubview(playerTwoButton)
    }
}
