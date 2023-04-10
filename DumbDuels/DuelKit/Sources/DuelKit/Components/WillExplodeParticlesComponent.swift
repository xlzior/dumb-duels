//
//  WillExplodeParticlesComponent.swift
//  
//
//  Created by Esmanda Wong on 10/4/23.
//

import CoreGraphics

public class WillExplodeParticlesComponent: Component {
    public var id: ComponentID
    public var particles: [String]
    public var numExplodingParticles: Int
    public var particleSize: CGSize

    public var randomXDeltaRange: ClosedRange<CGFloat>
    public var randomYDeltaRange: ClosedRange<CGFloat>
    public var travelDistanceRange: ClosedRange<CGFloat>
    public var travelTime: CGFloat

    public init(particles: [String],
                numExplodingParticles: Int = 40,
                particleSize: CGSize = CGSize(width: 10, height: 10),
                randomXDeltaRange: ClosedRange<CGFloat> = -60...60,
                randomYDeltaRange: ClosedRange<CGFloat> = -60...60,
                travelDistanceRange: ClosedRange<CGFloat> = 15...80,
                travelTime: CGFloat = 1) {
        self.id = ComponentID()
        self.particles = particles
        self.numExplodingParticles = numExplodingParticles
        self.particleSize = particleSize
        self.randomXDeltaRange = randomXDeltaRange
        self.randomYDeltaRange = randomYDeltaRange
        self.travelDistanceRange = travelDistanceRange
        self.travelTime = travelTime
    }
}
