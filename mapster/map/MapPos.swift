//
//  MapPos.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

// The MapPos is also the Vertex of the Graph
public struct MapPos : Hashable ,Equatable {
    var x : Int
    var y : Int
}
