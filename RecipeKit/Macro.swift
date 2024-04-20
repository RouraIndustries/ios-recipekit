//
//  Macro.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import Foundation
import SwiftData

@Model
final class Macro {
    var name: String = ""
    var quantity: Double = 0.0
    var unit: String = ""

    var recipe: Recipe?

    init(name: String, quantity: Double, unit: String) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
