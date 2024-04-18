//
//  Ingredient.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var name: String
    var quantity: Double
    var unit: String

    init(name: String, quantity: Double, unit: String) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
