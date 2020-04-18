//
//  Rectangle.swift
//  mapster
//
//  Created by Christian Gröling on 17.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

class Square {
    var mid : MapPos
    var length : Int
    init(_ mid: MapPos, _ length: Int ) {
        self.mid = mid
        self.length = length
    }

    func draw(map : Map<MapTile>) {

        //FloodFill.floodFill(start: mid, map: map,     )
    }

}
