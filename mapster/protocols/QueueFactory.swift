//
//  QueueFactory.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import datastructures

/// Factory protocol to create an queue conforming the QueueProcotol
protocol QueueFactory {
    associatedtype QueueType  : Queue
    func create() -> QueueType
}
