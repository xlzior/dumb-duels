//
//  GameController.swift
//  DuelKit
//
//  Created by Esmanda Wong on 17/3/23.
//

public protocol GameController {
    var onBackToHomePage: () -> Void { get set }
    func goToHomePage()
    func addView(for entityID: EntityID, with details: RenderDetails)
    func updateView(for entityID: EntityID, with details: RenderDetails)
    func updateScore(for playerIndex: Int, with newScore: Int)
    func removeViews(for entiyIDs: Set<EntityID>)
}
