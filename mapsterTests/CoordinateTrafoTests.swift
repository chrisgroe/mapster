//
//  PolarTransformationTest.swift
//  mapsterTests
//
//  Created by Christian Gröling on 18.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
@testable import mapster

class CoordinateTrafoTests : XCTestCase {
    func testForwardBack() {

        let testVector = [(4.78, 8.2), (1.33, -2.0), (-10, -2.0)]
        var actualVector = Array<(Double,Double)>()
        for test in testVector {
            let x = test.0
            let y = test.1

            let (radius, rho) = CoordinateTrafo.cartesianToPolar(x,y)
            let (xAct, yAct) = CoordinateTrafo.polarToCartesian(radius, rho)
            actualVector.append((xAct, yAct))

        }
        for (test, actual) in zip(testVector, actualVector) {
            XCTAssertEqual(actual.0, test.0, accuracy : 1e-6)
            XCTAssertEqual(actual.1, test.1, accuracy : 1e-6)
        }
    }

    func testBackForward() {

        let testVector = [(4.78, 20/180 * Double.pi), (1.33, 90/180 * Double.pi), (5, -90/180 * Double.pi)]
        var actualVector = Array<(Double,Double)>()
        for test in testVector {
            let radius = test.0
            let phi = test.1

            let (x, y) = CoordinateTrafo.polarToCartesian(radius,phi)
            let (radiusAct, phiAct) = CoordinateTrafo.cartesianToPolar(x,y)
            actualVector.append((radiusAct, phiAct))

        }
        for (test, actual) in zip(testVector, actualVector) {
            XCTAssertEqual(actual.0, test.0, accuracy : 1e-6)
            XCTAssertEqual(actual.1, test.1, accuracy : 1e-6)
        }
    }

    func testForwardBackInt() {
        var testVector = Array<(Int,Int)>()
        for x in -100...100 {
            for y in -100...100 {
                testVector.append((x,y))
            }
        }

        var actualVector = Array<(Int,Int)>()
        for test in testVector {
            let x = test.0
            let y = test.1

            let (radius, rho) = CoordinateTrafo.discreteCartesianToPolar(x,y)
            let (xAct, yAct) = CoordinateTrafo.polarToDiscreteCartesian(radius, rho)
            actualVector.append((xAct, yAct))

        }
        for (test, actual) in zip(testVector, actualVector) {
            XCTAssertEqual(actual.0, test.0)
            XCTAssertEqual(actual.1, test.1)
        }
    }

}
