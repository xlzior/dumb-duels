//
//  GameController.swift
//  DumbDuels
//
//  Created by Esmanda Wong on 17/3/23.
//

protocol GameController {
    func registerPlayerID(playerIndex: Int, playerEntityID: EntityID)
    func updateScore()
    func render()
}
