//
//  Queue.swift
//  mapster
//
//  Created by Christian Gröling on 13.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol Queue : class {
    associatedtype Element
    init()
    func push(_ element: Element)
    func pop() -> Element?
}

