//
//  Recipe.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var summary: String
    var instructions: [String]

    @Relationship(deleteRule: .cascade)
    var ingredients: [Ingredient]?
    @Relationship(inverse: \CuisineType.recipes)
    var cuisineTypes: [CuisineType]?
    
    init(title: String, summary: String, instructions: [String]) {
        self.title = title
        self.summary = summary
        self.instructions = instructions
    }
}
