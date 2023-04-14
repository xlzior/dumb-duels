//
//  TTPhysicsCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

class TTPhysicsCreator {
    func createPlatform(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: TTPhysics.platformPhysicsDetails)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: TTPhysics.wallPhysicsDetails)
    }

    func createBottomBoundary(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: TTPhysics.bottomBoundaryPhysicsDetails)
    }

    func createBlock(of size: CGSize, area: Int) -> PhysicsComponent {
        let blockPhysicsDetails = TTPhysics.getBlockPhysicsDetails(of: CGFloat(area))
        return PhysicsComponent(rectangleOf: size, with: blockPhysicsDetails)
    }
}
