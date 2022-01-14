//
//  Car.swift
//  CarCustomiser
//
//  Created by Wreford, Barnaby (PGW) on 14/01/2022.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    func displayStats() -> String {
        return "Make: \(make)\nModel: \(model)\nTop Speed: \(topSpeed)mph\nAcceleration: (0-60): \(acceleration)s\nHandling: \(handling)"
    }
}
