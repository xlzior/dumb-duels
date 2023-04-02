//
//  File.swift
//  
//
//  Created by Bing Sen Lim on 29/3/23.
//

import Foundation

public protocol IndexMapInitializable {
    var playerIndexToIdMap: [Int: EntityID] { get set }
    func setPlayerId(firstPlayer: EntityID, secondPlayer: EntityID)

}
