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
    var playerButtons: [PlayerButton] = []
    var playerScores: [ScoreLabel] = []

    var gameManager: GameManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGameView()
        setUpGestureRecognisers()
        setUpGameManager()
    }

    private func setUpGameView() {
        gameView = GameAreaView(screenSize: screenSize)
        view.addSubview(gameView)

        let playerOneButton = PlayerButton(screenSize: screenSize, isPlayerOne: true)
        let playerTwoButton = PlayerButton(screenSize: screenSize, isPlayerOne: false)
        playerButtons.append(contentsOf: [playerOneButton, playerTwoButton])
        view.addSubview(playerOneButton)
        view.addSubview(playerTwoButton)

        let playerOneScore = ScoreLabel(screenSize: screenSize, isPlayerOne: true)
        let playerTwoScore = ScoreLabel(screenSize: screenSize, isPlayerOne: false)
        playerScores.append(contentsOf: [playerOneScore, playerTwoScore])
        view.addSubview(playerOneScore)
        view.addSubview(playerTwoScore)
    }

    private func setUpGestureRecognisers() {
        for playerButton in playerButtons {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed))

            playerButton.addGestureRecognizer(tapRecognizer)
            playerButton.addGestureRecognizer(longPressRecognizer)
        }
    }

    private func setUpGameManager() {
        gameManager = GameManager(gameController: self, screenSize: screenSize)
    }

    @objc func buttonTapped(tapRecognizer: UITapGestureRecognizer) {
        guard let playerID = (tapRecognizer.view as? PlayerButton)?.playerID else {
            return
        }
        gameManager?.handleButtonPress(for: playerID)
    }

    @objc func buttonLongPressed(longPressRecognizer: UILongPressGestureRecognizer) {
        assertionFailure("buttonLongPressed method should not be called")
    }
}

extension GameViewController: GameController {
    func registerPlayerID(playerIndex: Int, playerEntityID: EntityID) {
        playerButtons[playerIndex].playerID = playerEntityID
        playerScores[playerIndex].playerID = playerEntityID
    }

    func updateScore() {

    }

    func render() {

    }
}
