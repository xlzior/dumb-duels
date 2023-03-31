//
//  ScoreComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

public class ScoreComponent: Component {
    public var id: ComponentID
    public var score: Int
    public var playerId: EntityID
    // TODO: change this to index

    public init(score: Int = 0, for playerId: EntityID) {
        self.id = ComponentID()
        self.score = score
        self.playerId = playerId
    }
}
