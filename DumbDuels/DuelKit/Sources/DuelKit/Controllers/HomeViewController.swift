//
//  HomeViewController.swift
//  
//
//  Created by Esmanda Wong on 15/4/23.
//

import UIKit

public class HomeViewController: UIViewController {
    var screenSize: CGSize = UIScreen.main.bounds.size

    public weak var homeViewDelegate: HomeViewDelegate? {
        didSet {
            homeViewDelegate?.styleBackground(view: self.view)
            homeViewDelegate?.loadGameIconsAndViewControllers(self)
            setUpView()
        }
    }

    public var gameLogo: String?
    public var gameIcons: [String] = []
    public var gameViewControllers: [() -> UIViewController] = []

    private func setUpView() {
        createGameLogo()
        createGameIconButtons()
    }

    private func createGameLogo() {
        guard let gameLogo else {
            return
        }

        let logo = HomeLogo(screenSize: screenSize, logo: gameLogo)
        view.addSubview(logo)
    }

    private func createGameIconButtons() {
        assert(gameIcons.count == gameViewControllers.count)
        GameIconButton.totalNumButtons = gameIcons.count
        for (index, gameIcon) in gameIcons.enumerated() {
            let gameIconButton = GameIconButton(screenSize: screenSize, index: index, icon: gameIcon)
            gameIconButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            gameIconButton.isExclusiveTouch = true
            view.addSubview(gameIconButton)
        }
    }

    @objc private func buttonAction(sender: UIButton!) {
        guard let index = (sender as? GameIconButton)?.index else {
            return
        }
        navigationController?.pushViewController(gameViewControllers[index](), animated: true)
    }
}
