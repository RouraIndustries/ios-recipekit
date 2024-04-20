//
//  SavedRecipes.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import Foundation
import SwiftData

@Model
final class SavedRecipes {
    var savedRecipes: [Recipe] = []

    init(savedRecipes: [Recipe]) {
        self.savedRecipes = savedRecipes
    }
}
