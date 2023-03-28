//
//  HomeViewController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 11/3/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func playButtonClicked(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(
            withIdentifier: "GameViewController"
        ) as? AxeGameViewController else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }

}