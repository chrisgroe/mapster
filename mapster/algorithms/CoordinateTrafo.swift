//
//  PolarTransformation#.swift
//  mapster
//
//  Created by Christian Gröling on 18.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

class CoordinateTrafo {
    // do not allow construction of this class
    private init() {

    }

    /// Converts a vector in cartesian coordinates to polar coordinates.
    /// - Parameters:
    ///   - x: x component of cartesian vector
    ///   - y: y component of cartesian vector
    /// - Returns: A tuple containing the vector in polar coordinates
    static func cartesianToPolar(_ x: Double, _ y: Double) -> (radius: Double, phi:Double) {
        return (
            radius: sqrt(x*x + y*y),
            phi: atan2(y,x)
        )
    }

    /// Convertes a vector in polar coordinates to a vector in cartesian coordinates
    /// - Parameters:
    ///   - radius: the radius of the coordinate vector
    ///   - phi: the angle of the coordinate vector
    /// - Returns: A tuple containing the vector in cartesian coordinates
    static func polarToCartesian(_ radius: Double, _ phi: Double) -> (x: Double, y: Double) {
        return (
            x : radius * cos(phi),
            y : radius * sin(phi)
        )
    }

    /// Converts a Int vector in cartesian coordinates to polar coordinates.
    /// - Parameters:
    ///   - x: x component of cartesian vector
    ///   - y: y component of cartesian vector
    /// - Returns: A tuple containing the vector in polar coordinates
    static func discreteCartesianToPolar(_ x: Int, _ y: Int) -> (radius: Double, phi:Double) {
        cartesianToPolar(Double(x), Double(y))
    }

    /// Convertes polar coordinates to discrete cartesian coordinates.
    /// - Parameters:
    ///   - radius: the radius of the coordinate vector
    ///   - phi: the angle of the coordinate vector
    /// - Returns: A discrete vector in cartesian coordinates
    static func polarToDiscreteCartesian(_ radius: Double, _ phi: Double) -> (x: Int, y: Int) {
        return (
            x : Int(round(radius * cos(phi))),
            y : Int(round(radius * sin(phi)))
        )
    }

    
}
