//
//  TAPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 7/4/23.
//

import CoreGraphics
import DuelKit

class TAPhysicsCreator {
    func createTank(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: TAPhysics.tankPhysicsDetails)
    }

    func createCannonball(of size: CGSize, direction: CGFloat) -> PhysicsComponent {
        let cannonballPhysicsDetails = TAPhysics.getCannonballPhysicsDetails(
            with: TAConstants.cannonballSpeed * CGVector(angle: direction))
        return PhysicsComponent(circleOf: size.height / 2, with: cannonballPhysicsDetails)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: TAPhysics.wallPhysicsDetails)
    }

    func createSideWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: TAPhysics.sideWallPhysicsDetails)
    }
}
