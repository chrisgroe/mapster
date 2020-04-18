//
//  Rectangle.swift
//  mapster
//
//  Created by Christian Gröling on 17.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol RadialShape {
    associatedtype Element
    var center : (x: Int, y: Int) {
        get
    }
    func radialFunc(radius : Double, phi: Double ) -> Bool
}

extension RadialShape {
    func draw(map: Map<Element>, transform : (_ element: Element) -> (Element)) -> Map<Element> {
        var result = map // copy
        map.bfsTraverse(
            start: MapPos(x: center.x, y: center.y),
            visitor: {pos in
                result[pos] = transform(map[pos])
            },
            isBlocked: {pos in
                let x = pos.x - center.x
                let y = pos.y - center.y
                let (radius, phi) = PolarTransformation.discreteCartesianToPolar(x, y)
                return radialFunc(radius: radius, phi: phi)
            }
        )
        return result
    }
}

struct SquareShape<T> : RadialShape {
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

    func radialFunc(radius : Double, phi: Double) -> Bool {
        // convert polar coordinates back to cartesian ones. This
        // is a lot easiert to handle than trying to represent the square
        // in polar coordinates
        let (x, y) = PolarTransformation.polarToDiscreteCartesian(radius, phi)
        return abs(x) >= self.length || abs(y) >= self.length
    }
}

struct CircleShape<T> : RadialShape {
    typealias Element = T
    var mid: MapPos
    var center : (x: Int, y: Int) {
        get {
            return (x: mid.x, y: mid.y)
        }
    }
    var radius : Double
    init(_ mid: MapPos, _ radius: Double ) {
        self.mid = mid
        self.radius = radius
    }

    func radialFunc(radius : Double, phi: Double) -> Bool {
        return radius > self.radius
    }
}

