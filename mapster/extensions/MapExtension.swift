//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


extension Map where Element == MapTile{
    
    func floodFill(_ pos:MapPos, factory: (_ pos : MapPos)->MapTile) -> Map<MapTile> {
        return FloodFill.floodFill(start: pos, map: self, factory: factory)
    }
}

