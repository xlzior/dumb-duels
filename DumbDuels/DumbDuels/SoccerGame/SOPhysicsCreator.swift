//
//  SOPhysicsCreator.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 11/4/23.
//

import CoreGraphics
import DuelKit

class SOPhysicsCreator {
    func createPlayer(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: SOPhysics.playerPhysicsDetails)
    }

    func createBall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(circleOf: size.height / 2, with: SOPhysics.ballPhysicsDetails)
    }

    func createGoal(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: SOPhysics.goalPhysicsDetails)
    }

    func createGoalSide(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: SOPhysics.goalSidePhysicsDetails)
    }

    func createGoalBack(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: SOPhysics.goalBackPhysicsDetails)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: SOPhysics.wallPhysicsDetails)
    }
}
