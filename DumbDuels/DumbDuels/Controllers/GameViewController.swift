//
//  GameViewController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 11/3/23.
//

import UIKit

class GameViewController: UIViewController {
    var screenSize: CGSize = UIScreen.main.bounds.size
    var screenOffset = CGPoint()

    var gameView: UIView!
    var playerButtons: [PlayerButton] = []
    var playerScores: [ScoreLabel] = []
    var entityViews: [EntityID: UIImageView] = [:]

    var gameManager: GameManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGameView()
        setUpGestureRecognisers()
        setUpGameManager()
    }

    private func setUpGameView() {
        gameView = GameAreaView(screenSize: screenSize)
        screenOffset = gameView.frame.origin
        view.addSubview(gameView)
        view.addSubview(GameAreaBorder(screenSize: screenSize, gameAreaFrame: gameView.frame))

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
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongPressed))
            longPressRecognizer.minimumPressDuration = 0

            playerButton.addGestureRecognizer(longPressRecognizer)
        }
    }

    private func setUpGameManager() {
        let details = RenderSystemDetails(gameController: self, screenSize: screenSize, screenOffset: screenOffset)
        gameManager = GameManager(renderSystemDetails: details)
    }

    @objc func buttonLongPressed(longPressRecognizer: UILongPressGestureRecognizer) {
        guard let playerID = (longPressRecognizer.view as? PlayerButton)?.playerID else {
            return
        }

        if longPressRecognizer.state == .began {
            gameManager?.handleButtonDown(for: playerID)
        } else if longPressRecognizer.state == .ended {
            gameManager?.handleButtonUp(for: playerID)
        }
    }
}

extension GameViewController: GameController {
    func registerPlayerID(playerIndex: Int, playerEntityID: EntityID) {
        playerButtons[playerIndex].playerID = playerEntityID
        playerScores[playerIndex].playerID = playerEntityID
    }

    func addView(for entityID: EntityID, with details: RenderDetails) {
        let entityView = createView(details)
        entityViews[entityID] = entityView
        view.addSubview(entityView)
    }

    func updateView(for entityID: EntityID, with details: RenderDetails) {
        guard let entityViewToUpdate = entityViews[entityID] else {
            return
        }
        setUpView(entityViewToUpdate, details)
    }

    func removeViews(for entityIDs: Set<EntityID>) {
        for entityID in entityIDs {
            removeView(for: entityID)
        }
    }

    private func createView(_ details: RenderDetails) -> UIImageView {
        let entityView = setUpView(UIImageView(frame: CGRect()), details)
        return entityView
    }

    @discardableResult
    private func setUpView(_ imageView: UIImageView, _ details: RenderDetails) -> UIImageView {
        imageView.image = UIImage(named: details.spriteName)
        imageView.transform = CGAffineTransform(rotationAngle: 0)
        imageView.frame = CGRect(x: 0, y: 0, width: details.width, height: details.height)
        imageView.center = details.centerPosition
        imageView.transform = CGAffineTransform(rotationAngle: details.rotation)

        if details.facing == .left {
            imageView.transform = CGAffineTransformScale(imageView.transform, -1, 1)
        }

        return imageView
    }

    private func removeView(for entityID: EntityID) {
        guard let entityViewToRemove = entityViews[entityID] else {
            return
        }
        entityViewToRemove.removeFromSuperview()
    }

    func updateScore(for entityID: EntityID, with newScore: Int) {
        for score in playerScores where score.playerID == entityID {
            score.text = String(newScore)
        }
    }
}
