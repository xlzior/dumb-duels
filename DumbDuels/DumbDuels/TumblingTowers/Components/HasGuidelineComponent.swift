//
//  HasGuidelineComponent.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 12/4/23.
//

import DuelKit

class HasGuidelineComponent: Component {
    var id: ComponentID
    var guidelineId: EntityID

    init(guidelineId: EntityID) {
        self.id = ComponentID()
        self.guidelineId = guidelineId
    }
}
