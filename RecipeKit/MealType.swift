//
//  MealType.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import Foundation
import SwiftData

@Model
final class MealType {
    var name: String = ""

    var recipes: [Recipe]?

    init(name: String) {
        self.name = name
    }
}
