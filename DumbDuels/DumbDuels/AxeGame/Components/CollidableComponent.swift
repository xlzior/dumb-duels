//
//  CollidableComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 17/3/23.
//

import Foundation

class CollidableComponent: Component {
    var id: ComponentID

    var categories: [any CollisionCategory]

    init(categories: any CollisionCategory...) {
        id = ComponentID()
        self.categories = categories
    }
}
