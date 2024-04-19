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
    var type: String = ""

    var recipes: [Recipe]?

    init(type: String) {
        self.type = type
    }
}
