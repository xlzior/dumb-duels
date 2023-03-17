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
    var collisions: [any CollisionCategory]
    var contacts: [any CollisionCategory]

    init(categories: any CollisionCategory...,
         collisions: any CollisionCategory...,
         contacts: any CollisionCategory...) {
        id = ComponentID()
        self.categories = categories
        self.collisions = collisions
        self.contacts = contacts
    }
}
