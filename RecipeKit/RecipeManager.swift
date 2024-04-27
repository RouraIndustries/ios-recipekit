//
//  RecipeManager.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import SwiftUI
import Observation

@Observable final class RecipeManager {
    var recipes: [V0_Recipe] = []
    var cuisineTypes: [V0_CuisineType] = []
    var mealTypes: [V0_MealType] = []
    var ingredients: [V0_Ingredient] = []
    var nutritionalInformation: [V0_NutritionalInformation] = []
    var macros: [V0_Macro] = []
    var stats: [V0_Stat] = []
}
