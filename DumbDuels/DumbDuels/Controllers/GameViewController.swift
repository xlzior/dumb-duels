//
//  GameViewController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 11/3/23.
//

import UIKit

class GameViewController: UIViewController {
    var screenSize: CGSize = UIScreen.main.bounds.size

    var gameView: UIView!
    var playerOneButton: UIButton!
    var playerTwoButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGameView()
        setUpGestureRecognisers()
    }

    private func setUpGameView() {
        gameView = GameAreaView(screenSize: screenSize)
        view.addSubview(gameView)

        playerOneButton = PlayerButton(screenSize: screenSize, isPlayerOne: true)
        playerTwoButton = PlayerButton(screenSize: screenSize, isPlayerOne: false)
        view.addSubview(playerOneButton)
        view.addSubview(playerTwoButton)
    }

    private func setUpGestureRecognisers() {
        for playerButton in [playerOneButton, playerTwoButton] {
            let tapRecognizer = UITapGestureRecognizer(target: playerButton, action: #selector(buttonTapped))
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed))

            playerButton?.addGestureRecognizer(tapRecognizer)
            playerButton?.addGestureRecognizer(longPressRecognizer)
        }
    }

    @objc func buttonTapped(tapRecognizer: UITapGestureRecognizer) {
        assertionFailure("buttonTapped method should not be called")
    }

    @objc func buttonLongPressed(longPressRecognizer: UILongPressGestureRecognizer) {
        assertionFailure("buttonLongPressed method should not be called")
    }
}
