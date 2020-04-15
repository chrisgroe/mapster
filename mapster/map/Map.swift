//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


public struct Map<T> : NavigatableGraph
{
    typealias Vertex = MapPos
    typealias Element = T
    
    var map : Array<Array<Element>>
    let xlen : Int
    let ylen : Int
    
    init?(_ xlen: Int, _ ylen: Int, _ factory: (_ pos : MapPos)->T) {
        
        self.xlen = xlen
        self.ylen = ylen
        guard xlen>0 && ylen>0 else {
            return nil
        }
        
        map = Array<Array<T>>(repeating: Array<T>(), count: xlen)
        for (x, var row) in map.enumerated() {
            for y in 0..<ylen {
                row.append(factory(MapPos(x:x, y:y)))
            }
            map[x] = row
        }
    }
    
    init?(_ mapString : String, _ factory: (_ pos : MapPos, _ ch: Character)->T) {
        
        let mapLines = mapString.split(separator: "\n")
        var chars = Array<Array<Character>>()
        
        let yl = mapLines.count
        let xl = mapLines[0].count
        
        for _ in 0..<xl {
            let row = Array<Character>(repeating: "O", count: yl)
            
            chars.append(row)
        }
        
        for (y,row) in mapLines.enumerated() {
            for (x,ch) in row.enumerated() {
                chars[x][y] = ch
            }
        }
        
        self.init(xl,yl, {pos in
            factory(pos, chars[pos.x][pos.y])
        })
    }
    
    subscript(_ x : Int, _ y: Int) -> T {
        
        set {
            assert(x>=0 && x<xlen)
            assert(y>=0 && y<ylen)
            map[x][y] = newValue
            
        }
        get {
            assert(x>=0 && x<xlen)
            assert(y>=0 && y<ylen)
            return map[x][y]
        }
    }
    
    subscript(_ pos : MapPos) -> T {
        set {
            self[pos.x, pos.y] = newValue
        }
        
        get {
            self[pos.x, pos.y]
        }
        
    }
    
    
    func isInBounds(x:Int, y:Int ) -> Bool {
        if x>=0 && x<xlen && y>=0 && y<ylen {
            return true
        }
        return false
    }
    
    
    class NeighborIterator : IteratorProtocol {
        typealias Element = Vertex
        
        var step : Int = 0
        var x : Int = 0
        var y : Int = 0
        var master : Map<T>
        
        init(_ x: Int, _ y : Int, _ master : Map<T>){
            self.x = x
            self.y = y
            self.master  = master
        }
        func isInBounds(x:Int, y:Int ) -> Bool {
            if x>=0 && x<master.xlen && y>=0 && y<master.ylen {
                return true
            }
            return false
        }
        func next() -> Element? {
            while (step < 5) {
                switch (step) {
                case 0:
                    step += 1
                    if isInBounds(x: x+1, y: y) {
                        return (MapPos(x: x+1, y: y))
                    }
                    
                case 1:
                    step += 1
                    if isInBounds(x: x, y: y+1) {
                        return(MapPos(x: x, y: y+1))
                    }
                case 2:
                    step += 1
                    if isInBounds(x: x-1, y: y) {
                        return (MapPos(x: x-1, y: y))
                    }
                    
                case 3:
                    step += 1
                    if isInBounds(x: x, y: y-1) {
                        return (MapPos(x: x, y: y-1))
                    }
                    
                default:
                    return nil
                }
            }
            return nil
        }
        
        
    }
    func getNeighborIterator(of vertex: Vertex) -> NeighborIterator {
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        return NeighborIterator(vertex.x, vertex.y, self)
    }
    
}
