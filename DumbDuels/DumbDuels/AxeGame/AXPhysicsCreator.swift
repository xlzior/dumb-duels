//
//  AXPhysicsCreator.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 18/3/23.
//

import Foundation
import DuelKit

class AXPhysicsCreator {
    func createAxe(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(circleOf: size.height / 2, with: AXPhysics.axePhysicsDetails)
    }

    func createPlayer(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: AXPhysics.playerPhysicsDetails)
    }

    func createPlatform(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: AXPhysics.platformPhysicsDetails)
    }

    func createWall(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: AXPhysics.wallPhysicsDetails)
    }

    func createPeg(of size: CGSize) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: AXPhysics.pegPhysicsDetails)
    }

    func createParticle(of radius: CGFloat, with initialImpulse: CGVector) -> PhysicsComponent {
        let axeParticlePhysicsDetails = AXPhysics.getAxeParticlePhysicsDetails(with: initialImpulse)
        return PhysicsComponent(circleOf: radius, with: axeParticlePhysicsDetails)
    }

    func createLava(of size: CGSize, for lavaId: EntityID) -> PhysicsComponent {
        PhysicsComponent(rectangleOf: size, with: AXPhysics.lavaPhysicsDetails)
    }
}
