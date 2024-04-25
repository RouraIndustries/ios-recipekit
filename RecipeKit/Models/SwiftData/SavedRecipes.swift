//
//  SavedRecipes.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import Foundation
import SwiftData

@Model
final class SavedRecipe {
    let id = UUID()
    var recipeID: String?

    init(recipeID: String) {
        self.recipeID = recipeID
    }
}
