//
//  TTPhysics.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import DuelKit
import CoreGraphics

struct TTPhysics {
    static let platformMass: CGFloat = 100.0
    static let platformGravity = false
    static let platformCor: CGFloat = 0.0
    static let platformIsDynamic = false
    static let platformZRotation = PhysicsEngineDefaults.zRotation
    static let platformRotation = false
    static let platformFriction: CGFloat = 0
    static let platformLinearDamping: CGFloat = 0
    static let platformImpulse: CGVector = .zero
    static let platformAngularImpulse: CGFloat = .zero

    // This is also used for the separator
    // Except that the separator in the middle has a sprite
    static let wallMass: CGFloat = 100.0
    static let wallGravity = false
    static let wallCor: CGFloat = 0.0
    static let wallIsDynamic = false
    static let wallZRotation = PhysicsEngineDefaults.zRotation
    static let wallRotation = false
    static let wallFriction: CGFloat = 0
    static let wallLinearDamping: CGFloat = 0
    static let wallImpulse: CGVector = .zero
    static let wallAngularImpulse: CGFloat = .zero

    static let blockMass = 1.0
    static let blockGravity = false
    // Necessary because whne block is falling, it should stick to platform
    // But at the same time we want blocks that are landed to bounce off another block
    static let controlBlockCor: CGFloat = 0.0
    static let landedBlockCor: CGFloat = 0.2
    static let blockIsDynamic = true
    static let blockZRotation = PhysicsEngineDefaults.zRotation
    // TODO: Check if this rotation also needs to differentiate between landed and control
    static let blockRotation = true
    static let blockFriction: CGFloat = 0
    static let blockLinearDamping: CGFloat = 0
    static let blockImpulse: CGVector = .zero
    static let blockAngularImpulse: CGFloat = .zero

    static let scoreLineMass = 1.0
    static let scoreLineGravity = false
    static let scoreLineCor: CGFloat = 0.0
    static let scoreLineIsDynamic = false
    static let scoreLineZRotation = PhysicsEngineDefaults.zRotation
    static let scoreLineRotation = false
    static let scoreLineFriction: CGFloat = 0
    static let scoreLineLinearDamping: CGFloat = 0
    static let scoreLineImpulse: CGVector = .zero
    static let scoreLineAngularImpulse: CGFloat = .zero
}
