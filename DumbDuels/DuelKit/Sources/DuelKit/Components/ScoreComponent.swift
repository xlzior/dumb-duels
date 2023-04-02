//
//  ScoreComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

public class ScoreComponent: Component {
    public var id: ComponentID
    public var score: Int
    public var playerIndex: Int
    public var playerId: EntityID

    public init(for playerIndex: Int, withId playerId: EntityID, score: Int = 0) {
        self.id = ComponentID()
        self.playerIndex = playerIndex
        self.playerId = playerId
        self.score = score
    }
}
