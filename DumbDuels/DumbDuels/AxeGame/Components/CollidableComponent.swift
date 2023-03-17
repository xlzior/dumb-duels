//
//  CollidableComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

class CollidableComponent: Component {
    var id: ComponentID

    var categories: [CollisionCategory]

    init(categories: CollisionCategory...) {
        id = ComponentID()
        self.categories = categories
    }
}
