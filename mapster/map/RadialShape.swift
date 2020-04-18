//
//  Rectangle.swift
//  mapster
//
//  Created by Christian Gröling on 17.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol Shape {
    associatedtype Element
    var center : (x: Int, y: Int) {
        get
    }
    func radialFunc(x: Int, y: Int) -> Bool

}

extension Shape {
    func draw(map: Map<Element>, transform : (_ element: Element) -> (Element)) -> Map<Element> {
        var result = map // copy
        map.bfsTraverse(
            start: MapPos(x: center.x, y: center.y),
            visitor: {pos in
                result[pos] = transform(map[pos])
            },
            isBlocked: {pos in
                radialFunc(x: pos.x, y: pos.y)
            }
        )
        return result
    }
}

struct RadialShape<T> : Shape {
    typealias Element = T
    var mid: MapPos
    var center : (x: Int, y: Int) {
        get {
            return (x: mid.x, y: mid.y)
        }
    }
    var length : Int
    init(_ mid: MapPos, _ length: Int ) {
        self.mid = mid
        self.length = length
    }

    func radialFunc(x: Int, y: Int) -> Bool {
        return abs(x-mid.x) >= length || abs(y-mid.y) >= length
    }
}
