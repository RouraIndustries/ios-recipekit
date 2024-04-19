//
//  Stat.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import Foundation
import SwiftData

@Model
final class Stat {
    var name: String
    var quantity: Double

    var recipe: Recipe?

    init(name: String, quantity: Double) {
        self.name = name
        self.quantity = quantity
    }
}