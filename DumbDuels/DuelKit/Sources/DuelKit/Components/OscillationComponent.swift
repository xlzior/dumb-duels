//
//  OscillationComponent.swift
//  
//
//  Created by Bryan Kwok on 28/3/23.
//

import CoreGraphics

public class OscillationComponent: Component {
    public var id: ComponentID
    public var centerOfOscillation: CGPoint
    public var axis: CGVector
    public var amplitude: Double
    public var period: Double
    public var displacement: Double

    public init(centerOfOscillation: CGPoint, axis: CGVector,
                amplitude: Double, period: Double, displacement: Double) {
        self.id = ComponentID()
        self.centerOfOscillation = centerOfOscillation
        self.axis = axis
        self.amplitude = amplitude
        self.period = period
        self.displacement = displacement
    }
}
