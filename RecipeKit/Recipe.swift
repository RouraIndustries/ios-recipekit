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
    var content: String
    var allergenInformation: String
    var tipsAndVariations: [String]
    var instructions: [String]

    @Attribute(.externalStorage)
    var imageData: Data?

    @Relationship(deleteRule: .cascade)
    var ingredients: [Ingredient]?
    @Relationship(deleteRule: .cascade)
    var macros: [Macro]?
    @Relationship(deleteRule: .cascade)
    var nutritionalInformation: [NutritionalInformation]?
    @Relationship(deleteRule: .cascade)
    var stats: [Stat]?
    @Relationship(inverse: \CuisineType.recipes)
    var cuisineTypes: [CuisineType]?
    @Relationship(inverse: \MealType.recipes)
    var mealTypes: [MealType]?

    init(
        title: String,
        content: String,
        allergenInformation: String,
        tipsAndVariations: [String],
        instructions: [String]
    ) {
        self.title = title
        self.content = content
        self.allergenInformation = allergenInformation
        self.tipsAndVariations = tipsAndVariations
        self.instructions = instructions
    }
}
