//
//  GameViewController.swift
//  DuelKit
//
//  Created by Esmanda Wong on 11/3/23.
//

import UIKit

open class GameViewController: UIViewController {
    var screenSize: CGSize = UIScreen.main.bounds.size
    var screenOffset = CGPoint()

    var gameView: UIView!
    var playerButtons: [PlayerButton] = []
    var playerScores: [ScoreLabel] = []
    var entityViews: [EntityID: UIImageView] = [:]

    public var renderSystemDetails: RenderSystemDetails?
    public var gameManager: GameManager?

    override open func viewDidLoad() {
        super.viewDidLoad()
        setUpGameView()
        setUpGestureRecognisers()
        setUpRenderSystemDetails()
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

    private func setUpRenderSystemDetails() {
        renderSystemDetails = RenderSystemDetails(
            gameController: self, screenSize: screenSize, screenOffset: screenOffset)
    }

    open func setUpGameManager() {
        assertionFailure("Override in child class")
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
    public func registerPlayerID(playerIndex: Int, playerEntityID: EntityID) {
        playerButtons[playerIndex].playerID = playerEntityID
        playerScores[playerIndex].playerID = playerEntityID
    }

    public func goToHomePage() {
        navigationController?.popViewController(animated: true)
    }

    public func addView(for entityID: EntityID, with details: RenderDetails) {
        let entityView = createView(details)
        entityViews[entityID] = entityView
        view.addSubview(entityView)
    }

    public func updateView(for entityID: EntityID, with details: RenderDetails) {
        guard let entityViewToUpdate = entityViews[entityID] else {
            return
        }
        setUpView(entityViewToUpdate, details)
    }

    public func removeViews(for entityIDs: Set<EntityID>) {
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
        imageView.alpha = details.alpha
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

    public func updateScore(for entityID: EntityID, with newScore: Int) {
        for score in playerScores where score.playerID == entityID {
            score.text = String(newScore)
        }
    }
}
