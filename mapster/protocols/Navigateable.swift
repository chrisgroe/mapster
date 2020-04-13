//
//  Navigateable.swift
//  mapster
//
//  Created by Christian Gröling on 13.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol Navigatable {
    associatedtype Element
    func getNeighbours(coords : Element) -> [Element]
}

