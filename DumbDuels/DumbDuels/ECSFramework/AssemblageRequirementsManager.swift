//
//  AssemblageRequirementsManager.swift
//  DumbDuels
//
//  Created by Bing Sen Lim on 14/3/23.
//

import Foundation

protocol AssemblageRequirementsManager {
    associatedtype Components
    associatedtype ComponentTypes
    associatedtype EntityAndComponents
    
    init(_ types: ComponentTypes)
    
    var componentTypes: [Component.Type] { get }
}
