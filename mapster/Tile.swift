//
//  Tile.swift
//  mapster
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

public struct Tile : Equatable{
    let x : Int
    let y : Int
    
    
    var coords : (Int, Int) {
        return (x, y)
    }
}
