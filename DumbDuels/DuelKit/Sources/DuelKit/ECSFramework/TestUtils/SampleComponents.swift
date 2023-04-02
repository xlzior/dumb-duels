//
//  SampleComponents.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 15/3/23.
//
// swiftlint:disable identifier_name
import Foundation

class XComponent: ComponentInitializable {
    var id: ComponentID
    var x: Int

    init(_ x: Int) {
        self.x = x
        id = ComponentID()
    }

    required init() {
        x = 1
        id = ComponentID()
    }
}

class YComponent: ComponentInitializable {
    var id: ComponentID
    var y: Int

    init(_ y: Int) {
        self.y = y
        self.id = ComponentID()
    }

    required init() {
        y = 1
        id = ComponentID()
    }
}

class ZComponent: Component {
    var id: ComponentID
    var z: Int

    init(_ z: Int) {
        self.z = z
        self.id = ComponentID()
    }
}

class WComponent: Component {
    var id: ComponentID
    var w: Int

    init(_ w: Int) {
        self.w = w
        self.id = ComponentID()
    }
}

class AComponent: Component {
    var id: ComponentID
    var a: Int

    init(_ a: Int) {
        self.a = a
        self.id = ComponentID()
    }
}

class BComponent: Component {
    var id: ComponentID
    var b: Int

    init(_ b: Int) {
        self.b = b
        self.id = ComponentID()
    }
}

class CComponent: Component {
    var id: ComponentID
    var c: Int

    init(_ c: Int) {
        self.c = c
        self.id = ComponentID()
    }
}

class DComponent: Component {
    var id: ComponentID
    var d: Int

    init(_ d: Int) {
        self.d = d
        self.id = ComponentID()
    }
}
