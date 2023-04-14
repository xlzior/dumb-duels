//
//  SPPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 27/3/23.
//

import CoreGraphics
import DuelKit

class SPPhysicsCreator {
    func createSpaceship(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size - CGSize(width: 20, height: 10), with: SPPhysics.spaceshipPhysicsDetails)
    }

    func createRock(of size: CGSize, velocity: CGVector) -> PhysicsComponent {
        let rockPhysicsDetails = SPPhysics.getRockPhysicsDetails(with: SPConstants.rockForce * velocity)
        return PhysicsComponent(circleOf: size.height / 2, with: rockPhysicsDetails)
    }

    func createBullet(of size: CGSize, pointing: CGFloat) -> PhysicsComponent {
        let bulletPhysicsDetails = SPPhysics.getBulletPhysicsDetails(
            with: SPConstants.bulletForce * CGVector(angle: pointing))
        return PhysicsComponent(rectangleOf: size, with: bulletPhysicsDetails)
    }

    func createPowerup(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(circleOf: size.height / 2, with: SPPhysics.powerupPhysicsDetails)
    }
}
