//
//  MapTypes.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

struct MapTypes<T> : GraphTypes {
    typealias Vertex = Map<T>.Vertex
    typealias NavGraph = Map<T>
}

