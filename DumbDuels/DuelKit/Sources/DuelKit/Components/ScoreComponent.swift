//
//  ScoreComponent.swift
//  DuelKit
//
//  Created by Esmanda Wong on 16/3/23.
//

public class ScoreComponent: Component {
    var id: ComponentID
    var score: Int

    init(score: Int = 0) {
        self.id = ComponentID()
        self.score = score
    }
}
