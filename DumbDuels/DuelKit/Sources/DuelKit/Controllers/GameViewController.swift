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

    public var gameView: UIImageView!
    var playerButtons: [PlayerButton] = []
    var playerScores: [ScoreLabel] = []
    var entityViews: [EntityID: UIImageView] = [:]
    public var onBackToHomePage: () -> Void = {}
    public var gameManager: GameManager?

    override open func viewDidLoad() {
        super.viewDidLoad()
        setUpGameView()
        styleGameViewBackground()
        setUpGestureRecognisers()
        setUpGameManager()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        onBackToHomePage()
    }

    open func styleGameViewBackground() {}

    private func setUpGameView() {
        gameView = GameAreaView(screenSize: screenSize)
        screenOffset = gameView.frame.origin
        view.addSubview(gameView)
        view.addSubview(GameAreaBorder(screenSize: screenSize, gameAreaFrame: gameView.frame))

        let playerOneButton = PlayerButton(screenSize: screenSize, isPlayerOne: true, index: 0)
        let playerTwoButton = PlayerButton(screenSize: screenSize, isPlayerOne: false, index: 1)
        playerButtons.append(contentsOf: [playerOneButton, playerTwoButton])
        view.addSubview(playerOneButton)
        view.addSubview(playerTwoButton)

        let playerOneScore = ScoreLabel(screenSize: screenSize, isPlayerOne: true, index: 0)
        let playerTwoScore = ScoreLabel(screenSize: screenSize, isPlayerOne: false, index: 1)
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

    open func setUpGameManager() {
        assertionFailure("Override in child class")
    }

    @objc func buttonLongPressed(longPressRecognizer: UILongPressGestureRecognizer) {
        guard let playerIndex = (longPressRecognizer.view as? PlayerButton)?.index else {
            return
        }

        if longPressRecognizer.state == .began {
            gameManager?.handleButtonDown(for: playerIndex)
        } else if longPressRecognizer.state == .ended {
            gameManager?.handleButtonUp(for: playerIndex)
        }
    }
}

extension GameViewController: GameController {
    func goToHomePage() {
        onBackToHomePage()
        navigationController?.popViewController(animated: true)
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

    public func updateScore(for playerIndex: Int, with newScore: Int) {
        for score in playerScores where score.index == playerIndex {
            score.text = String(newScore)
        }
    }
}
