//
//  HomeLogo.swift
//  
//
//  Created by Esmanda Wong on 15/4/23.
//

import UIKit

class HomeLogo: UIImageView {
    init(screenSize: CGSize, logo: String) {
        super.init(image: UIImage(named: logo))
        scale(screenSize.height)
        position(screenSize)
    }

    private func scale(_ screenHeight: CGFloat) {
        let scalingFactor = screenHeight * 0.35 / frame.height
        transform = CGAffineTransform(scaleX: scalingFactor, y: scalingFactor)
    }

    private func position(_ screenSize: CGSize) {
        let xPos = (screenSize.width - frame.width) / 2
        frame = CGRect(
            x: xPos,
            y: screenSize.height * 0.15,
            width: frame.width,
            height: frame.height
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
