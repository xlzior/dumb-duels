//
//  HomeViewDelegate.swift
//  
//
//  Created by Esmanda Wong on 16/4/23.
//

import UIKit

public protocol HomeViewDelegate: AnyObject {
    func styleBackground(view: UIView)
    func loadGameIconsAndViewControllers(_ homeView: HomeViewController)
}
