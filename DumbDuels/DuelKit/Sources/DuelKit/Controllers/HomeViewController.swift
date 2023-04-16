//
//  HomeViewController.swift
//  
//
//  Created by Esmanda Wong on 15/4/23.
//

import UIKit

open class HomeViewController: UIViewController {
    var screenSize: CGSize = UIScreen.main.bounds.size

    public var gameLogo: String?
    public var gameIcons: [String] = []
    public var gameViewControllers: [() -> UIViewController] = []

    override open func viewDidLoad() {
        super.viewDidLoad()

        styleBackground()
        loadGameIconsAndViewControllers()
        setUpView()
    }

    open func styleBackground() {
        view.backgroundColor = #colorLiteral(red: 227 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
    }

    open func loadGameIconsAndViewControllers() {
    }

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

    @objc
    private func buttonAction(sender: UIButton!) {
        guard let index = (sender as? GameIconButton)?.index else {
            return
        }
        navigationController?.pushViewController(gameViewControllers[index](), animated: true)
    }
}
