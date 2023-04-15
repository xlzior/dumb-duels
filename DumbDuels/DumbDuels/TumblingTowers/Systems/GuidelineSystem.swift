//
//  GuidelineSystem.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 11/4/23.
//

import CoreGraphics
import DuelKit

// This system is responsible for syncing guidelines for blocks
class GuidelineSystem: System {

    private let entityManager: EntityManager
    private let controlBlocks: Assemblage6<
        BlockComponent, HasGuidelineComponent, PositionComponent,
        SizeComponent, RotationComponent, PhysicsComponent>
    private let guidelines: Assemblage3<SyncXPositionComponent, PositionComponent, SizeComponent>

    init(for entityManager: EntityManager) {
        self.entityManager = entityManager
        self.controlBlocks = entityManager.assemblage(
            requiredComponents: BlockComponent.self,
            HasGuidelineComponent.self, PositionComponent.self,
            SizeComponent.self, RotationComponent.self, PhysicsComponent.self)
        self.guidelines = entityManager.assemblage(requiredComponents: SyncXPositionComponent.self, PositionComponent.self, SizeComponent.self)
    }

    func update() {
        for (guideEntity, syncXPosition, guidePosition, guideSize) in guidelines.entityAndComponents {
            guard let (block, hasGuideline, blockPosition, blockSize, _, _) =
                    controlBlocks.getComponents(for: syncXPosition.syncFrom),
                hasGuideline.guidelineId == guideEntity.id else {
                continue
            }
            guidePosition.position.x = blockPosition.position.x
            let guideOriginalHeight: CGFloat = guideSize.originalSize.height
            if block.useWidthForGuideline {
                guideSize.originalSize = CGSize(width: blockSize.actualSize.width, height: guideOriginalHeight)
            } else {
                guideSize.originalSize = CGSize(width: blockSize.actualSize.height, height: guideOriginalHeight)
            }
        }
    }

}
