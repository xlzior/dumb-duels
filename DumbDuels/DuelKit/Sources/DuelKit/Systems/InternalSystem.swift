//
//  InternalSystem.swift
//  
//
//  Created by Wen Jun Lye on 14/4/23.
//

protocol InternalSystem: System {
    var priority: InternalSystemOrder { get set }
}
