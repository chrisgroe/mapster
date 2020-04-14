//
//  MapTypeTraits.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol GraphTypeTraits  {
    associatedtype Vertex 
    associatedtype NavGraph : NavigatableGraph where NavGraph.Vertex == Vertex
}
