//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

public class Map
{
    var map : Array<Array<Tile>>
    let xlen : Int
    let ylen : Int
    
    init?(_ xlen: Int, _ ylen: Int) {
        
        self.xlen = xlen
        self.ylen = ylen
        guard xlen>0 && ylen>0 else {
            return nil
        }
        
        map = Array<Array<Tile>>()
        for x in 0..<xlen {
            var row = Array<Tile>()
            
            for y in 0..<ylen {
                row.append(Tile(x:x, y:y))
            }
            
            map.append(row)
        }
    }
    
    
    subscript(_ x : Int, _ y: Int) -> Tile? {
        guard x>=0 && x<xlen else {
            return nil
        }
        
        guard y>=0 && y<ylen else {
            return nil
        }
        
        return map[x][y]
    }
}
