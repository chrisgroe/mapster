//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


public struct Map<T> : NavigatableGraph where T : MapVertexPos
{
    typealias Vertex = T
    
    var map : Array<Array<T>>
    let xlen : Int
    let ylen : Int
    
    init?(_ xlen: Int, _ ylen: Int, _ factory: (_ x : Int, _ y: Int)->T) {
        
        self.xlen = xlen
        self.ylen = ylen
        guard xlen>0 && ylen>0 else {
            return nil
        }
        
        map = Array<Array<T>>()
        for x in 0..<xlen {
            var row = Array<T>()
            
            for y in 0..<ylen {
                row.append(factory(x,y))
            }
            
            map.append(row)
        }
    }
    
    init?(_ mapString : String, _ factory: (_ x : Int, _ y : Int, _ ch: Character)->T) {
        
        let mapLines = mapString.split(separator: "\n")
        var chars = Array<Array<Character>>()
        
        let yl = mapLines.count
        let xl = mapLines[0].count
        
        for _ in 0..<xl {
            var row = Array<Character>()
            for _ in 0..<yl {
                row.append("O")
            }
            chars.append(row)
        }
        
        for (y,row) in mapLines.enumerated() {
            for (x,ch) in row.enumerated() {
                chars[x][y] = ch
            }
        }
        
        self.init(xl,yl, {x,y in
            factory(x,y, chars[x][y])
        })
    }
    
    
    
    
    subscript(_ x : Int, _ y: Int) -> T? {
        
        set {
            guard let val = newValue else {
                return
            }
            guard x>=0 && x<xlen else {
                return
            }
            
            guard y>=0 && y<ylen else {
                return
            }
            map[x][y] = val
            
        }
        get {
            guard x>=0 && x<xlen else {
                return nil
            }
            
            guard y>=0 && y<ylen else {
                return nil
            }
            
            return map[x][y]
        }
    }
    
    func getNeighbors(of node: Vertex) -> [Vertex] {
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        
        let neighb = [
            (x: Int(node.x)+1, y: Int(node.y)),
            (x: Int(node.x)  , y: Int(node.y)+1),
            (x: Int(node.x)-1, y: Int(node.y)),
            (x: Int(node.x)  , y: Int(node.y)-1),
        ]
        return neighb.compactMap{
            self[$0.x, $0.y] // nil values will be deleted by compactMap
        }
    }
    
}
