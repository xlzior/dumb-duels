//
//  EventConsumer.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 9/3/23.
//

protocol EventConsumer {
    func consume(event: Event) -> [Event]
}
