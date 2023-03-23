//
//  WithThrowStrengthComponent.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 23/3/23.
//

class WithThrowStrengthComponent: ComponentInitializable {
    var id: ComponentID
    var throwStrengthEntityId: EntityID

    init(throwStrengthEntityId: EntityID) {
        self.id = ComponentID()
        self.throwStrengthEntityId = throwStrengthEntityId
    }

    required init() {
        self.id = ComponentID()
        self.throwStrengthEntityId = EntityID()
    }
}
