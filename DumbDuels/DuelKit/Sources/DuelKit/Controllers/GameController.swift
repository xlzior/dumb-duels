//
//  GameController.swift
//  DuelKit
//
//  Created by Esmanda Wong on 17/3/23.
//

public protocol GameController {
    func registerPlayerID(playerIndex: Int, playerEntityID: EntityID)
    func addView(for entityID: EntityID, with details: RenderDetails)
    func updateView(for entityID: EntityID, with details: RenderDetails)
    func updateScore(for entityID: EntityID, with newScore: Int)
    func removeViews(for entiyIDs: Set<EntityID>)
}
