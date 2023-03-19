//
//  EventFirer.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 19/3/23.
//

protocol EventFirer: AnyObject {
    func fire(_ event: Event)
}
