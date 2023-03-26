//
//  EventFirer.swift
//  DuelKit
//
//  Created by Wen Jun Lye on 19/3/23.
//

public protocol EventFirer: AnyObject {
    func fire(_ event: Event)
}
