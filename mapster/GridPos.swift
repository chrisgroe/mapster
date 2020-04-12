//
//  Tile.swift
//  mapster
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

public struct GridPos : Equatable, Hashable, CustomDebugStringConvertible {

    let coords : UInt32 // trick to save memory
    
    var x : UInt16 {
        return UInt16(coords & 0xFFFF)
    }
    
    var y : UInt16 {
        return UInt16((coords >> 16) & 0xFFFF)
    }
    
    init(x : UInt16, y: UInt16) {
        coords = (UInt32(x) & 0xFFFF) + ((UInt32(y)&0xFFFF)<<16)
    }
    init(x : Int, y: Int) {
        coords = (UInt32(x) & 0xFFFF) + ((UInt32(y)&0xFFFF)<<16)
    }
    
    public static func == (lhs: GridPos, rhs: GridPos) -> Bool {
        return lhs.coords == rhs.coords
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(coords)
    }
    
    public var debugDescription: String {
        
        return "x:\(x) y:\(y)"
    }

}
